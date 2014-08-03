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

  def cache_key_from_models models
    plain_key = ""
    models.each do |m|
      count = m.count
      max_updated_at = m.maximum(:updated_at).to_s
      plain_key += "#{count}-#{max_updated_at}-"
    end
    plain_key
  end

end