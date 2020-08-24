module ApplicationHelper

  def get_text_item(name)
    item = TextItem.find_by(name: name)
    if !item
      return "[" + name + "]"
    else
      return item.content
    end
  end

  def get_text_item_rich(name)
    item = TextItem.find_by(name: name)
    if !item
      return "[" + name + ".rich_content]"
    else
      return item.rich_content
    end
  end

  def search(query)
    if !query
      return []
    end

    words = query.split(/[\s]+/)
    words.each do |word|
      word = "%#{word}%" # add wildcards to each word
    end
    logger.debug words

    results = Hash.new
    
    # pages
    pages = Page.where('title_'+I18n.locale.to_s+' ILIKE :query OR content_'+I18n.locale.to_s+' ILIKE :query', query: "%#{query}%").to_a
    results[:pages] = pages
    
    # people
    query_string_people = 'bio_'+I18n.locale.to_s+' ILIKE :query'
    words.each do |word|
      query_string_people += " OR first_name ILIKE '%"+word+"%'"
      query_string_people += " OR last_name ILIKE '%"+word+"%'"
    end
    people = Person.where(query_string_people, query: "%#{query}%")
    results[:people] = people.to_a

    # events
    events = Event.where('title_'+I18n.locale.to_s+' ILIKE :query OR description_'+I18n.locale.to_s+' ILIKE :query', query: "%#{query}%").to_a
    results[:events] = events

    # festivals
    festivals = Festival.where('name_'+I18n.locale.to_s+' ILIKE :query OR description_'+I18n.locale.to_s+' ILIKE :query', query: "%#{query}%").to_a
    results[:festivals] = festivals


    #events of people
    if people.length > 0 
      person_events = Event.where( :id => PersonEvent.where( :id => people.collect { |p| p.id } ).to_a.collect { |p| p.event_id } )
      results[:events] += person_events.to_a
    end

    #people of events
    if events.length > 0 
      person_events = Person.where( :id => PersonEvent.where( :id => events.collect { |e| e.id } ).to_a.collect { |p| p.person_id } )
      results[:people] += person_events.to_a
    end
    
    return results                  
  end

end
