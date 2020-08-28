class FestivalsController < ApplicationController
  include SeoHelper

  def show
    @festival = Festival.find(params[:id])
    @page = @festival.page
    set_meta_tags :title => (@festival.name)
    set_meta_tags :description => auto_generate_description(@festival.description) if @festival.description
    #render :layout => "application"

    redirect_to(@page)
  end

  def update
    festival = Festival.find(params[:id])
    festival.description = params[:festival][:description] if params[:festival][:description]
    festival.save!
    render status: 200, json: festival.to_json
  end


end
