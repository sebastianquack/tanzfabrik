class PagesController < ApplicationController

  # GET /pages/:id
  def show
    # check if slug was passed in
    if params[:id]
      #use regular query because friendly throws error if not found
      @page = Page.where(:slug => params[:id]).first 
      if @page
        # try to show special template with page slug name if exists      
        if !Dir.glob(Rails.root.join("app", "views", "pages", "#{@page.slug}.*")).empty?
          render "#{@page.slug}" and return
        end
      else
        # if page doesn't exist in db, check if template exists
        if !Dir.glob(Rails.root.join("app", "views", "pages", "#{params[:id]}.*")).empty?
          # if yes, render that template
          render "#{params[:id]}" and return
        else
          # if not, redirect to root in order to clean up url
          redirect_to root_path
        end
      end  
    else
      # no params passed in, go to default page
      @page = Page.friendly.find('start')
      render "start" and return # this works even if page start is not in db and exists only as template
    end
  end

  def update
    page = Page.friendly.find(params[:id])
    page.title = params[:page][:title] if params[:page][:title]
    page.content = params[:page][:content] if params[:page][:content]
    page.save!
    render status: 200, json: page.to_json
  end

end
