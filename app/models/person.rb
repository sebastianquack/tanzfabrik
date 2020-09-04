
class Person < ActiveRecord::Base
  translates :bio, :rich_content, fallback: :any

  has_many :person_events
  has_many :events, :through => :person_events

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  has_rich_text :rich_content_de
  has_rich_text :rich_content_en

  before_validation :fix_trix
  
  scope :kurslehrer, -> {
    joins("events")
    .where("event.type_id = 3")#,4,5,6
  }
  
  scope :ordered, -> {
    order("LOWER(last_name) ASC")
  } 

  private def fix_trix
    self.rich_content_1_de = ModelHelpers.fix_trix self.rich_content_1_de.to_s
    self.rich_content_1_en = ModelHelpers.fix_trix self.rich_content_1_en.to_s
    self.rich_content_2_de = ModelHelpers.fix_trix self.rich_content_2_de.to_s
    self.rich_content_2_en = ModelHelpers.fix_trix self.rich_content_2_en.to_s
  end    
    
  def name    
    return self.first_name.to_s + " " + self.last_name.to_s
  end
  
  def self.by_event_types types
    r = []
    types.each do |type|
      r += self.by_event_type(type)
    end
    return r
  end

  def self.by_event_type type
    if type.is_a? String
      event_type = EventType.where(:name => type).first
    else
      event_type = EventType.find(type)
    end
    if event_type
      return self.joins(:events).where(:events => {:type_id => event_type.id}).uniq.to_a
    else
      return []
    end
  end

  def kurslehrer?
    self.dance_intensive || self.events.any? { |e| [3, 4, 5, 6].include?(e.type_id) }
  end

  def artist?
    self.events.any? { |e| [1, 7, 8, 10].include?(e.type_id) }
  end

  def self.get_tag_separator_regex_string
    "[ ,;]+"
  end

  def self.get_all_tags
    all_tags = self.distinct.pluck(:tags).join(" ").split(/#{self.get_tag_separator_regex_string}/).uniq.sort
  end

end
