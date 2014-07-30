class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    set_meta_tags :title => (@event.title + " | " + @event.type.name)
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
