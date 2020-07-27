# Event Types (by convention)
# 1: Performance
# 2: Workshop
# 3: Kurs
# 4: Profitraining
# 5: Performance-Projekt
# 6: Kindertanz
# 7: Showing
# 8: Lecture-Performance
# 9: Gespräch/Talk

class Event < ActiveRecord::Base

  translates :title, :description, :rich_content, :warning, :info, fallback: :any

  has_rich_text :rich_content_de
  has_rich_text :rich_content_en
  
  belongs_to :type, :class_name => "EventType"

  has_many :festival_events
  accepts_nested_attributes_for :festival_events, :allow_destroy => true
  
  has_many :festivals, :through => :festival_events
  #accepts_nested_attributes_for :festivals, :allow_destroy => true

  has_many :person_events
  accepts_nested_attributes_for :person_events, :allow_destroy => true
  
  #has_many :people, -> { order "last_name ASC" }, :through => :person_events
  has_many :people, :through => :person_events
  
  # returns custom sorting if specified, otherwise standard alphabetical
  def people_sorted
    if self.custom_sorting
      return self.people
    else
      return self.people.sort_by{|p| p.last_name}
    end
  end


  accepts_nested_attributes_for :people, :allow_destroy => true

  has_many :event_details, :dependent => :destroy
  accepts_nested_attributes_for :event_details, :allow_destroy => true

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  # VALIDATIONS

  validates_numericality_of :price_regular,
      :only_integer => true,
      :allow_nil => true,
      :greater_than_or_equal_to => 0

  validates_numericality_of :price_reduced,
      :only_integer => true,
      :allow_nil => true,
      :greater_than_or_equal_to => 0
  
  validates_presence_of :type_id

  validates_format_of :facebook, :with => /\Ahttp.*facebook/i, :message => :invalid_facebook_link, :allow_blank => true

  class CourseWeeklyValidator < ActiveModel::Validator
    def validate(record)
      if record.type.id == 3 && record.event_details.any? { |ed| ed.repeat_mode.internal_name != "weekly" }
        record.errors[:name] << 'Kurs muss "wöchentliche" Zeiten haben'
      end
    end
  end

  validates_with CourseWeeklyValidator

  # METHODS

  # event_type to display
  def display_type
    if self.custom_type && !self.custom_type.empty?
      return self.custom_type
    else
      self.type.name
    end
  end

  def self.of_types type_ids
    where_clause = type_ids.map {|type_id| "event_types.id = " + type_id.to_s + " " }.join(" OR ")
    events = Event.joins(:type, :event_details).group('events.id').where(where_clause)
    return events
  end

  def self.in_same_listing_as(e)
    if Rails.configuration.stage_event_types.include?(e.type.id)
      where('type_id IN (?)', Rails.configuration.stage_event_types)
    else
      where('type_id = ?', e.type.id)
    end
  end

  def all_studios
    studios = []
    self.event_details.each { |ed| studios << ed.studio }
    return studios.uniq
  end

  def firsttime_in_studio studio
    ft = new Time()
    self.event_details.each do |ed|
      if ed.studio == studio
        if ed.starttime < ft
          ft = ed.starttime
        end
      end
    end
    return ft
  end

  def firsttime
    if self.event_details.length > 0
      self.event_details.min_by { |ed| ed.starttime} .starttime
    else 
      return nil
    end
  end

  def start_date
    if self.event_details.length > 0
      return self.event_details.min_by { |ed| ed.start_date} .start_date
    else 
      return nil
    end
  end

  def end_date
    if self.event_details.length > 0
      return self.event_details.max_by { |ed| ed.end_date} .end_date
    else
      return nil
    end
  end

  def tags
    tags = self.event_details.collect_concat { |ed| ed.tags }
    tags
  end
  
  def early_bird_date
    early_bird_weeks = ( self.id == 421 ? 4 : 2) # mormal: 2 weeks. special: 4 weeks!
    
    # normal: thursday 3 week earlier
    date = self.start_date.beginning_of_week.next_day(3) - (early_bird_weeks + (self.start_date.wday <= 4 ? 1 : 0)).week
    if (date.month == 12 && [24,31].include?(date.day)) 
      date = date.prev_day(2)
    end

    # special case: when the workshops runs only sat-sun, but there are others workshops running thu-sun in the same week
    # result: the weekend workshop should have the same early bird date as the others
    #if (self.start_date.day == self.end_date.prev_day(1).day)
    #  others = Event.workshop.where(:end_date_cache => self.end_date).where(:start_date_cache => self.end_date.prev_day(3))
    #  date = date.prev_day(7) if others.count > 0
    #end

    # special case: if christmas holidays -> one week earlier
    if (date.month == 12 && [25,26].include?(date.day))
      date = date.prev_day(7)
    end
    
    date
  end
  
  def workshop_select
    I18n.l(self.start_date, :format => :short) + "-" + I18n.l(self.end_date, :format => :short) + " | " +
    "#{title} | " + self.festivals.map { |f| f.name }.join(", ") + (self.festivals.length > 0 ? " | " : "") + self.tags.uniq.map { |t| t.name }.join(", ") + " | #{price_regular},-€ / #{price_reduced},-€*"
  end

  def keywords # TODO: add keywords model with priorities to combine keywords from different sources
    k = []
    k << self.display_type
    k += self.people.collect_concat {|p| p.last_name}
    k << self.title
    k << "Berlin"
    k << "Tanzfabrik"
  end
  
  scope :no_draft, -> { where("events.draft = ? OR events.draft IS NULL", false) }
  scope :no_no_sign_up, -> { where("events.no_sign_up = ? OR events.no_sign_up IS NULL", false) }
  
  scope :stage_event, -> { where('type_id IN (?)', Rails.configuration.stage_event_types) }

  scope :workshop, -> { where('type_id IN (?)', 2) }

  scope :not_in_festival, -> { includes(:festival_events).where(:festival_events => { :event_id => nil }) }

  scope :currently_listed, -> { joins(:event_details).where('event_details.end_date >= ?', Date.today).uniq }

  scope :have_own_page, -> { where('type_id IN (?)', Rails.configuration.event_types_with_page) }

  def has_own_page?
    Rails.configuration.event_types_with_page.include? self.type.id
  end

  def stage_event?
    Rails.configuration.stage_event_types.include? self.type.id
  end

  def workshop_event?
    self.type_id == 2
  end

  def pp_event?
    self.type_id == 5
  end

  # TODO: use this code in timetable generation too. But make sure that it's correct
  def currently_listed_course?
    if([3,5,6].include? self.type_id) # is this an event of type course?
      # is there an occurrence coming up in the next 12 weeks?
      if(EventDetailOccurrence.where("event_id = ? AND time > ? AND time < ?", self.id, Time.now, Time.now + 12.week).count > 0)
        return true
      end
      # is start_date equal to end_date? by convention this means for weekly events: run forever
      if (self.start_date == self.end_date)
        return true
      end      
    end
    return false
  end

  # maybe wrong??
  def currently_listed?
    Event.currently_listed.where(id: self.id).count == 1
  end

  def process_time(time_url)
    if time_url # time is supplied through url
      time = Time.strptime(time_url, (I18n.t :url, scope: "time.formats"))
      # the 0 offset is important to get the time zone right... not fully sure why
      return Time.new(time.year, time.month, time.day, time.hour, time.min, time.sec, "+00:00") 
    else # infer from first occurrence of self
      return EventDetailOccurrence.where(:event_id => self.id).order("time ASC").first.time
    end
  end

  def next(time_url = nil, event_types = [], festival_id = nil)
    time = process_time(time_url)

    # special sorting inside blocks for workshops        
    if event_types == [2]
      
      # get flat list of workshops
      
      workshop_list = ApplicationController.helpers.get_workshop_groups_sorted_flat(self.start_date_cache.year)
      #puts workshop_list
      
      # find self
      index = workshop_list.index{|workshop| workshop.id == self.id}
      #puts index
        
      # give back next index or nil
      if index < workshop_list.length - 1
        return workshop_list[index + 1].first_event_occurrence
      else 
        return nil
      end
      
      #workshops_in_block = Event.where_festival(festival_id).where("type_id = 2 AND start_date_cache = ? AND end_date_cache = ?", self.start_date_cache, self.end_date_cache)
      
      #puts "block"
      #workshops_in_block.each { |e| puts e.title }
      
      #workshops_in_block_sorted = ApplicationController.helpers.workshops_sort(workshops_in_block)
      #workshops_in_block_sorted = workshops_in_block.to_a.sort_by! { |e| e.title.split("/")[0].to_i } 
      # assuming format: "NUMBER / TITLE"
      
      #puts "block_sorted"
      #workshops_in_block_sorted.each { |e| puts e.title }

      
      # find self and next element in block
      #next_workshop_in_block = nil
      #workshops_in_block_sorted.each_with_index do |e, index| 
      #  if e.id == self.id
      #    if index < workshops_in_block_sorted.length - 1
      #      next_workshop_in_block = workshops_in_block_sorted[index + 1] 
      #    end
      #  end
      #end   

      #if next_workshop_in_block
      #  return next_workshop_in_block.first_event_occurrence
      #else         
      #  workshops_in_next_block = Event.where_festival(festival_id).where("type_id = 2 AND  (start_date_cache != ? OR end_date_cache != ?) AND (start_date_cache > ? OR (start_date_cache = ? AND title_de > ?))", self.start_date_cache, self.end_date_cache, self.start_date_cache, self.start_date_cache, self.title)
        ## warning: doesn't get next block properly!!
        
      #  puts "next_block"
      #  workshops_in_next_block.each { |e| puts e.title }
                
        # sort first by start_date, then by title number
        #workshops_in_next_block_sorted = workshops_in_next_block.to_a.sort_by! { |e| [e.title.split("/")[0].to_i, e.start_date_cache] } 
       # workshops_in_next_block_sorted = ApplicationController.helpers.workshops_sort(workshops_in_next_block)
        
        #puts "next_block_sorted"
        #workshops_in_next_block_sorted.each { |e| puts e.title }
        
        
        #if workshops_in_next_block_sorted[0]
         # return workshops_in_next_block_sorted[0].first_event_occurrence
        #else 
         # return nil
        #end
        #end 

    # chronological sorting for everything else
    else
    
      oc = EventDetailOccurrence.joins(:event)
          .no_draft
          .where("events.type_id IN (?)", event_types)
          .where("event_detail_occurrences.time >= ?", time)
          .where("NOT (event_detail_occurrences.time = ? AND events.title_de < ?)", time, self.title_de)
          .where_festival(festival_id) # defined in event_detail_occurrences model
          .where("events.id != ?", self.id) # prevent event from showing all its occurrences
          .order("event_detail_occurrences.time ASC, events.title_de ASC")
          .first    
      return oc

    end
  end  
     
  def prev(time_url = nil, event_types = [], festival_id = nil)
    time = process_time(time_url)

    # alphanetical sorting inside blocks for workshops        
    if event_types == [2]

      #workshops_in_block = Event.where_festival(festival_id).where("type_id = 2 AND start_date_cache = ? AND end_date_cache = ?", self.start_date_cache, self.end_date_cache)

      #workshops_in_block_sorted = workshops_in_block.to_a.sort_by! { |e| e.title.split("/")[0].to_i } .reverse!
      # assuming format: "NUMBER / TITLE"
      #workshops_in_block_sorted = ApplicationController.helpers.workshops_sort(workshops_in_block) .reverse!
      
      
      # find self and next element in block
      #prev_workshop_in_block = nil
      #workshops_in_block_sorted.each_with_index do |e, index| 
      #  if e.id == self.id
      #    if index < workshops_in_block_sorted.length - 1
      #      prev_workshop_in_block = workshops_in_block_sorted[index + 1] 
      #    end
      #  end
      #end   
      
      #if prev_workshop_in_block
      #  return prev_workshop_in_block.first_event_occurrence
      #else         
        
        #workshops_in_prev_block = Event.where_festival(festival_id).where("type_id = 2 AND  (start_date_cache != ? OR end_date_cache != ?) AND start_date_cache <= ?", self.start_date_cache, self.end_date_cache, self.start_date_cache)
        
        # sort first by start_date, then by title number
        #workshops_in_prev_block_sorted = workshops_in_prev_block.to_a.sort_by! { |e| [e.start_date_cache, e.title.split("/")[0].to_i] }.reverse!
        #workshops_in_prev_block_sorted = ApplicationController.helpers.workshops_sort(workshops_in_prev_block) .reverse!
        #### FUNKTIONIERT NICHT
        
        #puts "sorted"
        #workshops_in_prev_block_sorted.each { |e| puts e.title }
        
        #if workshops_in_prev_block_sorted[0]
        #  return workshops_in_prev_block_sorted[0].first_event_occurrence
        #else 
        #  return nil
        #end
        #end
        
        
        # get flat list of workshops
        workshop_list = ApplicationController.helpers.get_workshop_groups_sorted_flat(self.start_date_cache.year)
        #puts workshop_list
      
        # find self
        index = workshop_list.index{|workshop| workshop.id == self.id}
        #puts index
        
        # give back next index or nil
        if index > 0
          return workshop_list[index - 1].first_event_occurrence
        else 
          return nil
        end

    # chronological sorting for everything else
    else

      oc = EventDetailOccurrence.joins(:event)
          .no_draft
          .where("events.type_id IN (?)", event_types)
          .where("event_detail_occurrences.time <= ?", time)
          .where("NOT (event_detail_occurrences.time = ? AND events.title_de > ?)", time, self.title_de)
          .where_festival(festival_id) # defined in event_detail_occurrences model
          .where("events.id != ?", self.id)
          .order("event_detail_occurrences.time DESC, events.title_de DESC")
          .first
      return oc
    end
  end

  def reset_occurrences
    logger.debug "resetting occurrences on event " + self.id.to_s

    EventDetailOccurrence.where(:event_id => self.id).delete_all

    self.event_details.each do |event_detail|
      event_detail.reset_occurrences
    end    
  end

  def occurs?
    #return self.event_details.count > 0
    EventDetailOccurrence.where(:event_id => self.id).count > 0
  end

  def occurs_on? date 
    self.event_details.each do |detail|
      if detail.occurs_on? date 
        return true
      end
    end
    return false
  end
  
  def occurrences_between(start_date, end_date)
    occurrences = []
    self.event_details.each do |detail|
      occurrences += detail.occurrences_with_detail_reference_between(start_date, end_date)
    end
    return occurrences
  end
  
  def occurrences_on date 
    return (self.occurrences_between date, date)
  end

  def next_occurrence
    return EventDetailOccurrence.where(:event_id => self.id).order("time").select {|o| o.time > Time.now }.first
  end
  
  def first_event_occurrence
    return EventDetailOccurrence.where(:event_id => self.id).order("time").first
  end

  def last_event_occurrence
    return EventDetailOccurrence.where(:event_id => self.id).order("time").last
  end

  def self.where_festival(festival_id)
    if festival_id
      where("events.id IN (?)", Festival.find(festival_id).events.pluck(:id))      
    else
      where("")
    end
  end

  def date_range_for_search_result
    if self.type_id.in?([3]) # empty if kurs (only currently active courses should appear / there is no archive)
      return []
    elsif self.first_event_occurrence.nil? || self.last_event_occurrence.nil?
      return []
    elsif self.first_event_occurrence.time.to_date == self.last_event_occurrence.time.to_date
      return [self.first_event_occurrence.time.to_date]
    else
      return [self.first_event_occurrence.time.to_date, self.last_event_occurrence.time.to_date]
    end
  end
    
end
