module EventsHelper

  def occurrence_path(event, time, festival = nil)
    if festival
      festival = Festival.find(festival)
      return festival_path(festival) + "/events/" + event.id.to_s + "/" + l(time, :format => :url)  
    else
      return event_path(event) + "/" + l(time, :format => :url)
    end
  end
  
  def occurrence_path_no_time(event, festival)
    if(festival)
      festival = Festival.find(festival)
      return festival_path(festival) + "/events/" + event.id.to_s
    else 
      return event_path(event)
    end
  end

end
