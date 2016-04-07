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

  def workshops_sort(workshops)
    # Many workshops are named in the following way: ENUMERATOR / TITLE.
    # Known formats of ENUMERATOR so far (3/2016):
    #   X
    #   X L
    #   X L+L
    #   L XX
    #   L XXL
    #   LXX
    #   LXX+LXX           
    # Legend:
    #   X = Number without leading zero, e.g. 1 or 10
    #   XX = Number with leading zero, e.g. 01 or 10
    #   L = Letter. At the beginning typically "S" for summer, at the end typically A, B or C to name a series of workshops
    # Tricks:
    #   e.title.split(" ").slice(1..2).count("/") ---------------- put entries without slash (not enumerated in the above way) at first
    #   e.title.split("/")[0].to_i                ---- case X ---- put 1 before 10
    workshops.sort_by { |e| [e.title.split(" ").slice(1..2).count("/"), e.title.split("/")[0].to_i, e.title] } 
  end

end
