class FestivalsController < ApplicationController

  def show
    @festival = Festival.find(params[:id])
  end

  def update
    festival = Festival.find(params[:id])
    festival.description = params[:festival][:description] if params[:festival][:description]
    festival.save!
    render status: 200, json: festival.to_json
  end


end
