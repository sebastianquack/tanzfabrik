module ApplicationHelper

  def search(query)
    if !query
      return []
    end

    words = query.split(/[\s.-–—]+/)
    words.each do |word|
      word = "%#{word}%" # add wildcards to each word
    end

    results = Hash.new
    
    # pages
    pages = Page.where('title_'+I18n.locale.to_s+' ILIKE :query OR content_'+I18n.locale.to_s+' ILIKE :query', query: "%#{query}%").to_a
    results[:pages] = pages
    
    # people
    query_string_people = 'bio_'+I18n.locale.to_s+' ILIKE :query'
    words.each do |word|
      query_string_people += ' OR first_name ILIKE :words'
      query_string_people += ' OR last_name ILIKE :words'
    end
    people = Person.where(query_string_people, query: "%#{query}%", words: words)
    results[:people] = people

    # events
    events = Event.where('title_'+I18n.locale.to_s+' ILIKE :query OR description_'+I18n.locale.to_s+' ILIKE :query', query: "%#{query}%").to_a
    results[:events] = events

    # festivals
    festivals = Festival.where('name_'+I18n.locale.to_s+' ILIKE :query OR description_'+I18n.locale.to_s+' ILIKE :query', query: "%#{query}%").to_a
    results[:festivals] = festivals
    
    return results                  
  end

end
