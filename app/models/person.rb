class Person < ActiveRecord::Base
  translates :bio, fallback: :any

  has_many :person_events
  has_many :events, :through => :person_events

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true

  scope :kurslehrer,
    joins("events")
    .where => "event.type_id = 3"#,4,5,6
  
  
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
    self.events.any? { |e| [3, 4, 5, 6].include?(e.type_id) }
  end

  def artist?
    self.events.any? { |e| [1, 7, 8, 10].include?(e.type_id) }
  end

end
