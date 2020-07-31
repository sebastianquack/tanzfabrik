class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_de, use: [:slugged, :finders]

  #friendly_id :slug, use: [:finders]
  
  translates :title, :content, :description, :feature_on_welcome_screen_note

  has_many :images
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  has_many :downloads
  accepts_nested_attributes_for :downloads, :allow_destroy => true
  
  has_many :content_modules, -> { order :order }, dependent: :destroy
  accepts_nested_attributes_for :content_modules, :allow_destroy => true

  require 'fuzzystringmatch'

  # determine the extension text for the selected menu item
  # remove parts that resemble the menu subject to avoid duplicate words 
  # 1) check if menu header text appears in page title at the beginning and cut it off
  #    example: "DANCE INTENSIVE/DANCE INTENSIVE PROGRAM" -> "DANCE INTENSIVE/PROGRAM"
  # 2) "Jubiläumsedition - Tanzklassen" -> "Jubiläumsedition"
  # 3) "Jubiläumsedition-Tanzklassen" -> "Jubiläumsedition"
  def title_for_menu_extension header_text
    selected_page_text = self.title
    # 1)
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
      # 2)
      pattern = " - " + header_text
      dist = !(pattern.length > selected_page_text.length) ? @jarow.getDistance(pattern, selected_page_text[(selected_page_text.length-pattern.length-1)..selected_page_text.length-1] ) : 0
      if dist > 0.9
        extension = selected_page_text[0..(selected_page_text.length-pattern.length-1)]
      else
        # 3)
        pattern = "-" + header_text
        dist = !(pattern.length > selected_page_text.length) ? @jarow.getDistance(pattern, selected_page_text[(selected_page_text.length-pattern.length-1)..selected_page_text.length-1] ) : 0
        if dist > 0.9
          extension = selected_page_text[0..(selected_page_text.length-pattern.length-1)]
        else
          extension = selected_page_text
        end
      end
    end    
  end

  scope :no_draft, -> { where("pages.draft = ? OR pages.draft IS NULL", false) }

  scope :in_project_menu, -> { where("pages.show_in_project_menu = ?", true).order("project_menu_order") }

end
