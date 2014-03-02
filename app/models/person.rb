class Person < ActiveRecord::Base

  has_many :person_events
  has_many :events, :through => :person_events

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

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
      return self.joins(:events).where(:events => {:type_id => event_type.id}).to_a
    else
      return []
    end
  end

end
