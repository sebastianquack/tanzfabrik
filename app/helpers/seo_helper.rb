module SeoHelper 
  require 'htmlentities'
  include ActionView::Helpers::SanitizeHelper

  def auto_generate_description html
    HTMLEntities.new.decode(ActionController::Base.helpers.strip_tags(html)[0..150])+"…"
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