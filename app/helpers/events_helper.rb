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

  # gets a flat list of workshops for given year using get_workshop_groups_sorted function
  def get_workshop_groups_sorted_flat(year)
    list = []
    workshop_groups = get_workshop_groups_sorted(year)
    workshop_groups.each do |dates, events|
      events.each do |workshop|
        list.push workshop
      end
    end
    return list
  end
    
  # generates a list of workshops grouped by dates and sorted inside groups by workshops_sort_function
  def get_workshop_groups_sorted(year)

    if year
      start_date = Date.parse('01-01-' + year.to_s)
      end_date = start_date.end_of_year
      workshops = Event.no_draft.joins(:type, :event_details).where('event_types.id = 2 AND event_details.start_date >= ? AND event_details.start_date <= ?', start_date, end_date).uniq
    else
      start_date = Date.parse('01-01-' + Time.now.year.to_s) # get workshops from beginning of year
      end_date = Time.now.to_s # don't show workshops that ended before today
      workshops = Event.no_draft.joins(:type, :event_details).where('event_types.id = 2 AND event_details.start_date >= ? AND event_details.end_date >= ?', start_date, end_date).uniq
    end
  
    events_by_dates = workshops
      .sort_by { |e| [e.firsttime, e.title] }
      .group_by { |e| [e.start_date, e.end_date] }
  
    events_by_dates.each do |dates, events|
      events_by_dates[dates] = workshops_sort events    
    end    
    
    return events_by_dates

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
