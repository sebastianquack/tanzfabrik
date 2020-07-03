class PagesController < ApplicationController
  include SeoHelper

  # GET /pages/:id
  def show

    @active_layout = "application2020";
    @menu_tree = {}
    @max_depth = 1

    # check if slug was passed in
    if params[:id]
      #use regular query because friendly throws error if not found
      @page = Page.where(:slug => params[:id]).first 
      if @page
        set_meta_tags :title => @page.title
        set_meta_tags :description => choose_page_description(@page)
      
        menu_item = MenuItem.find_by page_id: @page.id
        if menu_item
          @menu_tree = menu_item.subtree.arrange
        end

      else
        # if page not found, redirect to root in order to clean up url
        redirect_to root_path
      end  
    else
      # no params passed in, go to default page
      @page = Page.friendly.find('start')

      menu_item = MenuItem.find_by page_id: @page.id
      if menu_item
        @menu_tree = menu_item.subtree.arrange
      end
      @max_depth = 2
      
      render "start", :layout => @active_layout and return # this works even if page start is not in db and exists only as template
    end

    render :layout => @active_layout

  end

  def update
    page = Page.friendly.find(params[:id])
    page.title = params[:page][:title] if params[:page][:title]
    page.content = params[:page][:content] if params[:page][:content]
    page.save!
    render status: 200, json: page.to_json
  end

end
