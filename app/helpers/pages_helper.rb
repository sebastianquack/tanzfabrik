module PagesHelper

  def xeditable? object = nil
    admin_user_signed_in?
  end

  def kurs_link(kurs)
    url_for :controller => 'pages', :action => 'show', :id => "kursplan", :anchor => "#{kurs.id}"
  end

  def event_link(event)
    if(event.has_own_page?)
      return event_path(event)
    end    
    if(event.currently_listed_course?)
      return kurs_link(event)
    end
    return nil
  end

  def person_link(person)
    if person.kurslehrer?
      page = "lehrer" 
    elsif person.artist?
      page = "kuenstler"
    else
      return nil
    end

    url_for :controller => 'pages', :action => 'show', :id => page, :anchor => "#{person.id}"
  end  
    
end
