class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
  end

  def index
  end

  def update
    event = Event.find(params[:id])
    event.description = params[:event][:description] if params[:event][:description]
    event.save!
    render status: 200, json: event.to_json
  end

end
