require 'digest'

module CacheHelper
  def cache_key_for_kursplan events, location
    day                   = Date.today
    locale                = I18n.locale.to_s
    location_name         = location.name
    events_count          = events.count
    events_max_updated_at = events.maximum(:updated_at).to_s
    other_models          = cache_key_from_models([Tag,EventDetail,EventDetailTag,EventType,Location,Person,PersonEvent,Studio])
    #Time.now.to_s # TODO: add ", :touch => true" to models associated with event and activate key generation here
    return "kursplan/" + Digest::MD5.digest("#{locale}-#{day}-#{location_name}-#{events_count}-#{events_max_updated_at}-#{other_models}")
  end

  def cache_key_for_programm events, start_date
    month                 = Date.today.month
    locale                = I18n.locale.to_s
    start_date_string     = start_date.to_s
    events_count          = events.count
    events_max_updated_at = events.maximum(:updated_at).to_s
    other_models          = cache_key_from_models([EventDetail,EventType,Location,Person,PersonEvent,Studio])
    #Time.now.to_s # TODO: add ", :touch => true" to models associated with event and activate key generation here
    return "kursplan/" + Digest::MD5.digest("#{locale}-#{month}-#{start_date_string}-#{events_count}-#{events_max_updated_at}-#{other_models}")
  end


  def cache_key_from_models models
    plain_key = ""
    models.each do |m|
      count = m.count
      max_updated_at = m.maximum(:updated_at).to_s
      plain_key += "#{count}-#{max_updated_at}-"
    end
    plain_key
  end

  # Caches Arbre output.
  #
  # context - ActiveAdmin instance context
  # args    - Arguments passed to Rails.cache calls.
  #
  # Yielding the first time adds to the output buffer regardless of the
  # returned value. The missed cache must be handled carefully.
  #
  # Returns yielded Arbre on cache miss OR an HTML string wrapped in
  # an Arbre div on cache hit.
  def cache_arbre(context, *args)
    if controller.perform_caching && !admin_user_signed_in?
      if Rails.cache.exist?(*args)
        context.instance_eval do
          div(Rails.cache.read(*args))
        end
      else
        Rails.cache.write(*args, yield.to_s)
      end
    else
      yield
    end
  end

end