class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_de, use: [:slugged, :finders]

  translates :title, :content, :description, :feature_on_welcome_screen_note

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  has_many :downloads
  accepts_nested_attributes_for :downloads, :allow_destroy => true
  
  require 'fuzzystringmatch'

  def title_for_menu_extension header_text
    selected_page_text = self.title
    # check if menu header text appears in page title at the beginning and cut it off
    @jarow = FuzzyStringMatch::JaroWinkler.create( :pure )
    dist = @jarow.getDistance( header_text, selected_page_text[0..header_text.length-1] )
    if dist > 0.85
      matches = /[s]?[+&\s\/\\](.*)$/.match(selected_page_text[header_text.length-1..selected_page_text.length-1])
      if matches
        extension = matches[1].to_s
      else
        extension = selected_page_text
      end
    else
      extension = selected_page_text
    end    
  end

  scope :no_draft, -> { where("pages.draft = ? OR pages.draft IS NULL", false) }

end
