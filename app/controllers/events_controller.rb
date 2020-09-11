class EventsController < ApplicationController
  include SeoHelper
  include SchemaHelper

  def show
    @event = Event.find(params[:id])
    set_meta_tags :title => (@event.title + " | " + @event.type.name)
    set_meta_tags :description => auto_generate_description(@event.description) if @event.description
    set_meta_tags :keywords => (@event.keywords)
    add_to_jsonld event_jsonld(@event) if @event.stage_event?
    #render :layout => "application"
    @detail = @event.event_details.first

    # find appropriate section and landing page
    @section = @event.stage_event? ? "buehne" :  "schule"
    @landing_page = Page.where(slug: @section).first
    if @landing_page
      @landing_page_menu_item = MenuItem.where(page_id: @landing_page.id).first
    end

    @tag_string_1 = ""
    @tag_string_2 = ""
    if @detail.tags.length > 0 && @event.type.id == 3 # kurs
      @tag_string_2 = @detail.tags.map { |t| 
        if t.short.match(/^[a-zA-Z0-9]*$/)
           @tag_string_1 = helpers.get_text_item("tanklassen_level")+":" if @tag_string_1.empty?
          t.short 
        else
          t.name
        end
      }.join('/')
    end
  end

  def index
  end

  def update
    event = Event.find(params[:id])
    event.description = params[:event][:description] if params[:event][:description]
    event.info = params[:event][:info] if params[:event][:info]
    event.save!
    render status: 200, json: event.to_json
  end

end
