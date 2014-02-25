class Festival < ActiveRecord::Base

  has_many :festival_events
  has_many :events, :through => :festival_events

  #accepts_nested_attributes_for :festival_events, :allow_destroy => true
  #accepts_nested_attributes_for :events, :allow_destroy => true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
