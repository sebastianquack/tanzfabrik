module EventsHelper

 
  def get_prev_next_event_urls(event, time_url, in_festival)

    p_url = nil
    n_url = nil

    festival = nil
    if(in_festival != nil)
      festival = Festival.find(in_festival)
    end
        
    # stage events
    if event.stage_event? 
      list = []
      if(festival == nil)
        list = stage_events_occurrence_list(current_stage_events())
      else 
        festival_events = festival.events.no_draft.where.not(:type_id => 2)
        list = stage_events_occurrence_list(festival_events)
      end
      i = list.index{|oc| oc[:event].id == event.id && l(oc[:time], :format => :url) == time_url}
      if i != nil && i > 0
        p_url = occurrence_path(list[i - 1][:event], list[i - 1][:time], in_festival)
      end 
      if i != nil && i < list.length - 1
        n_url = occurrence_path(list[i + 1][:event], list[i + 1][:time], in_festival)
      end
    end

    # workshops && performance projects
    if event.type.id == 2 || event.type.id == 5
      
      if(festival == nil)
        list = current_workshops() if event.type.id == 2
        list = current_performance_projects() if event.type.id == 5
      else
        list = festival.events.no_draft.where(:type_id => 2)
      end

      i = list.index{|w| w.id == event.id}
      if i != nil && i > 0
        p_url = event_path(list[i - 1])
      end 
      if i != nil && i < list.length - 1
        n_url = event_path(list[i + 1])
      end
    end

    # proftrainings
    if event.type.id == 4
      list = current_profitrainings()
      i = list.index{|ed| ed.event.id == event.id}
      if i != nil && i > 0
        p_url = event_path(list[i - 1].event)
      end 
      if i != nil && i < list.length - 1
        n_url = event_path(list[i + 1].event)
      end
    end

    return [p_url, n_url]

  end

  # get current workshops for workshop programm
  def current_workshops()
    return Event.no_draft.joins(:event_details).where('type_id = 2 AND event_details.end_date >= ?', Date.today).uniq.sort_by{ |e| [e.start_date, e.title] }
  end

  # get current profitrainings
  def current_profitrainings()
    return profitrainings = EventDetail.joins(:event).where('events.type_id = 4 AND end_date >= ?', Date.today).sort_by{ |e| e.start_date }
  end

  # get current performance projects
  def current_performance_projects()
    return Event.no_draft.joins(:type, :event_details).where('event_types.id = 5').currently_listed.sort_by{ |e| e.start_date }
  end

  # gets events on current programm bühne
  def current_stage_events() 
    start_date = Date.today.beginning_of_month
    events = Event.no_draft.joins(:type, :event_details).where('event_types.id IN (?) AND event_details.start_date >= ?', Rails.configuration.stage_event_types, start_date)
  end

  # gets list of occurences to display
  def stage_events_occurrence_list(events)
    # make a list of all occurences from given events
    all_occurences = []
    events.includes(:people, :event_details => [:repeat_mode, :studio]).each do |event|
      event.event_details.each do |detail|
      
        # get occurrences
        occurrences = detail.occurrences
       
        if occurrences.length > 0
          occurrences.each do |oc|
            all_occurences << { :time => oc, :event => event, :detail => detail }
          end
        end
      end
    end
    return all_occurences.uniq.sort_by{ |o| o[:time] }
  end

  def event_path_with_festival(event, festival = nil)
    if festival
      if festival.is_a? Integer
        festival = Festival.find(festival.id)
      end
      return festival_path(festival) + "/events/" + event.id.to_s  
    else
      return event_path(event)
    end
  end

  def occurrence_path(event, time, festival = nil)
    if festival
      if festival.is_a? Integer
        festival = Festival.find(festival.id)
      end
      return festival_path(festival) + "/events/" + event.id.to_s + "/" + l(time, :format => :url)  
    else
      return event_path(event) + "/" + l(time, :format => :url)
    end
  end
  
  def occurrence_path_no_time(event, festival)
    if(festival)
      if !festival.is_a? Integer
        festival = Festival.find(festival.id)
      end
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
  def get_workshop_groups_sorted(year, festival_id = nil)

    if year
      start_date = Date.parse('01-01-' + year.to_s)
      end_date = start_date.end_of_year
      workshops = Event.no_draft.where_festival(festival_id).joins(:type, :event_details).where('event_types.id = 2 AND event_details.start_date >= ? AND event_details.start_date <= ?', start_date, end_date).uniq
    else
      start_date = Date.parse('01-01-' + Time.now.year.to_s) # get workshops from beginning of year
      end_date = Time.now.to_s # don't show workshops that ended before today
      workshops = Event.no_draft.where_festival(festival_id).joins(:type, :event_details).where('event_types.id = 2 AND event_details.start_date >= ? AND event_details.end_date >= ?', start_date, end_date).uniq
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
    #   L-X L ##not implemented yet
    #   L-X L+L ##not implemented yet
    # Legend:
    #   X = Number without leading zero, e.g. 1 or 10
    #   XX = Number with leading zero, e.g. 01 or 10
    #   L = Letter. At the beginning typically "S" for summer, at the end typically A, B or C to name a series of workshops
    # Tricks:
    #   e.title.split(" ").slice(1..2).count("/") ---------------- put entries without slash (not enumerated in the above way) at first
    #   e.title.split("/")[0].to_i                ---- case X ---- put 1 before 10 -- to_i on string extracts number in beginning
    workshops.sort_by { |e| [e.title.split(" ").slice(1..2).count("/"), e.title.split("/")[0].to_i, e.title] } 
    ## todo: update
  end

end
