# help generate structured data (https://schema.org/)

module SchemaHelper 
  require 'htmlentities'
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::TextHelper

  def html_to_text html
    html = html.gsub(/<\/b>|<br>|<\/p>/, " ")
    text = ActionController::Base.helpers.strip_tags(html)
    text = HTMLEntities.new.decode(text)
    text = text.gsub(/  /, " ").strip
  end  

  def jsonld
    @jsonld ||= []
  end

  def add_to_jsonld (data)
    data.each { |item| jsonld.push(item)}
  end

  def get_jsonld
    jsonld_complete = jsonld.map { |item| item[:@context] = "https://schema.org"; item }
    JSON.pretty_generate(jsonld_complete)
  end

  def jsonld_tag
    if jsonld.length > 0
      out = '<script type="application/ld+json">'
      out += get_jsonld
      out += '</script>'
      out.html_safe
    end
  end

  # https://schema.org/Event
  def event_jsonld(event) # event according to event model
    out = []
    return out if !event.stage_event? # only defined for stage events
    occurrences = EventDetailOccurrence.where(:event_id => event.id).includes(:event_detail).select("id","event_detail_id", "time")
    occurrences.each do |o|
      item = Hash.new
      item[:@type]      = "Event"
      item[:name]       = event.title
      item[:startDate]  = o.time.iso8601
      item[:endDate]    = (o.time + o.event_detail.duration.minutes).iso8601
      item[:url]        = event_url(event)
      item[:image]      = event.images.first.attachment.url(:medium_detail_column) if event.images.length > 0
      if !o.event_detail.custom_place.empty?
        item[:location]   = o.event_detail.custom_place
      else
        item[:location]   = place_jsonld(o.event_detail.full_location, o.event_detail.studio.location)
      end
      item[:performer] = event.people.map { |p| person_jsonld(p)}
      out << item
    end
    out
  end  

  # https://schema.org/place
  def place_jsonld(name, location = nil) # location according to location model
    item = Hash.new
    item[:@type] = "Place"
    item[:name] = name        
    #item[:address] = Hash.new
    #item[:address][:@type] = "PostalAddress"
    if location        
      item[:address] = location.address
      #item[:address][:streetAddress] = location.address
    end
    item
  end  

  # https://schema.org/person
  def person_jsonld(person) # person according to person model
    item = Hash.new
    item[:@type]      = "Person" # may be "@type": "PerformingGroup" etc if model was more precise
    item[:name]       = person.name
    if !person.last_name.empty? and !person.first_name.empty?
      item[:familyName] = person.last_name
      item[:givenName]  = person.first_name
    end
    item[:image]      = person.images.first.attachment.url(:medium_detail_column) if person.images.length > 0    
    item
  end  

end
