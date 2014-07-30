require 'digest'

module CacheHelper
  def cache_key_for_kursplan events
    day = Date.today
    locale = I18n.locale.to_s
    events_count          = events.count
    events_max_updated_at = events.maximum(:updated_at).to_s
    tags_count = Tag.count
    tags_max_updated_at = Tag.maximum(:updated_at).to_s
    studios_count = Studio.count
    studios_max_updated_at = Studio.maximum(:updated_at).to_s
    #{}"kursplan/" + Digest::MD5.digest("#{locale}-#{day}-#{events_count}-#{events_max_updated_at}-#{tags_count}-#{tags_max_updated_at}-#{studios_count}-#{studios_max_updated_at}")
    Time.now.to_s # TODO: add ", :touch => true" to models associated with event and activate key generation here
  end
end