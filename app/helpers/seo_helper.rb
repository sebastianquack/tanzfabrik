module SeoHelper 
  require 'htmlentities'
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::TextHelper

  def auto_generate_description html
    html = html.gsub(/<\/b>|<br>|<\/p>/, " ")
    text = ActionController::Base.helpers.strip_tags(html)
    text = HTMLEntities.new.decode(text)
    text = text.gsub(/  /, " ").strip
    text = ActionController::Base.helpers.truncate(text, length: 150, separator: ' ')
    text = text.gsub(/"/, " ").strip
    text
  end  

  def choose_page_description page
    if I18n.locale == :de
      if !@page.description_de || @page.description_de.empty?
        desc = auto_generate_description(@page.content_de) 
      else
        desc = @page.description_de
      end
    else
      if !@page.description_en || @page.description_en.empty?
        desc = auto_generate_description(@page.content_en) 
      else
        desc = @page.description_en
      end
    end
    desc
  end

end
