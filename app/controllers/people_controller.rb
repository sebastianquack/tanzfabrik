class PeopleController < ApplicationController
  include SeoHelper

  def show
    @person = Person.find(params[:id])
    set_meta_tags :title => (@person.name)
    #set_meta_tags :description => auto_generate_description(@person.bio) if @persion.bio

    # find appropriate section and landing page
    @section = @person.artist? && !@person.kurslehrer? ? "buehne" : "schule"
    @landing_page = Page.where(slug: @section).first
    if @landing_page
      @landing_page_menu_item = MenuItem.where(page_id: @landing_page.id).first
    end
  end
  
end
