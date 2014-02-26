class PagesController < ApplicationController

  # GET /pages/1
  def show

    if params[:id]
      @page = Page.where(:slug => params[:id]).first #use regular query because friendly throws error if not found
      if @page.nil?
        # redirect to root in order to clean up url
        redirect_to root_path
      end
    else
      @page = Page.friendly.find('welcome')
    end

    # try to show template with page slug name if exists      
    if @page
      if File.exists?(Rails.root.join("app", "views", "pages", "#{@page.slug}.html.erb"))
        render "#{@page.slug}" and return
      end
    end

  end

  def update
    page = Page.friendly.find(params[:id])
    page.title = params[:content][:page_title][:value]
    page.content = params[:content][:page_content][:value]
    page.save!
    render text: ""
  end

  private

end
