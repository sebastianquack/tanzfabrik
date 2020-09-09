class PagesController < ApplicationController
  include SeoHelper

  # GET /pages/:id
  def show

    #@active_layout = "application";
    @menu_tree = MenuItem.find_by(key: "start").subtree.arrange(:order => :position)
    @max_depth = 3

    # this finds the appropriate menu item from the section set in page
    def find_menu_item_for_orphan
      @menu_item = MenuItem.find_by key: @page.section
      if @menu_item
        #@menu_tree = @menu_item.descendants.arrange(:order => :position)
      end
      if @page.section 
        section_landing_page = Page.where(slug: @page.section).first
        if section_landing_page
          @landing_page_menu_item = MenuItem.where(page_id: section_landing_page.id).first
        end
      end
    end

    # check if slug was passed in
    if params[:id]
      #use regular query because friendly throws error if not found
      @page = Page.no_draft.where(:slug => params[:id]).first 
      
      if @page
        set_meta_tags :title => @page.title
        set_meta_tags :description => choose_page_description(@page)
      
        # load menu items referencing the page and use the one that is the deepest in the tree 
        menu_items = MenuItem.where(page_id: @page.id).sort {|a, b| b.depth <=> a.depth}

        if menu_items[0]
          @menu_item = menu_items[0]
          # always show menu from landing pages down
          # this is a landing page, show full subtree
          if menu_items[0].ancestors.length == 1 and ["buehne", "schule", "fabrik"].include? @page.slug
            #@menu_tree = menu_items[0].descendants.arrange(:order => :position) 
            @landing_page_menu_item = menu_items[0]
          elsif menu_items[0].ancestors.length > 1 # we are deeper, show from depth 1 down
            #@menu_tree = menu_items[0].ancestors[1].descendants.arrange(:order => :position) 
            @landing_page_menu_item = menu_items[0].ancestors[1]
          else
            # this is a menu item that is not in the tree
            find_menu_item_for_orphan
          end

        else 
          # page is not in nav tree, use section as starting point 
          find_menu_item_for_orphan
        end

      else
        # if page not found, redirect to root in order to clean up url
        redirect_to root_path
      end  
    else
      # no params passed in, go to default page
      @menu_item = MenuItem.find_by key: "start"
      if @menu_item
        @menu_tree = @menu_item.subtree.arrange(:order => :position)
      end
      
      render "start"
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
