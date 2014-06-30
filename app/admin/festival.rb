ActiveAdmin.register Festival do

  menu :priority => 2

  permit_params :name_de, :description_de, :name_en, :description_en, :feature_on_welcome_screen, :event_ids => [], 
    :images_attributes => [:id, :description, :license, :attachment, :_destroy],
    :downloads_attributes => [:id, :description_de, :description_en, :attachment, :_destroy]
    
  
  index do
    selectable_column
    column :name
    column :description
    column "Events" do |festival|
      festival.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
    end
    column "images" do |festival|
      festival.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    column "feature", :feature_on_welcome_screen
    default_actions
  end
  
  filter :name_de
  filter :description_de
  filter :feature_on_welcome_screen
   
  config.per_page = 10
    
  show do
    attributes_table do
      row :name
      row :description
      row :feature_on_welcome_screen
      row "Events" do |festival|
        festival.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
      end      
      row "images" do |festival|
        festival.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      end
      row "downloads" do |festival|
        festival.downloads.map { |d| link_to(d.description, d.attachment.url) }.join('').html_safe
      end
      
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name_de
      f.input :name_en
      f.input :description_de
      f.input :description_en
      f.input :events, :as => :check_boxes
    end

    f.inputs "Images" do
      f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        f_f.inputs do
          f_f.input :description
          f_f.input :license
          if f_f.object.attachment.exists?
            f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
          else
            f_f.input :attachment, :as => :file, :required => false
          end
        end
      end
    end
    
    f.inputs "Downloads" do
      f.has_many :downloads, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        f_f.inputs do
          f_f.input :description_de
          f_f.input :description_en
          if f_f.object.attachment.exists?
            f_f.input :attachment, :as => :file, :required => false, :hint => link_to(f_f.object.attachment.original_filename, f_f.object.attachment.url)
          else
            f_f.input :attachment, :as => :file, :required => false
          end
        end
      end
    end
    
    f.inputs "Special" do
      f.input :feature_on_welcome_screen
    end
    
    f.actions
  end
  
  controller do
    def reset_events
      Event.where(:feature_on_welcome_screen => true).load.each do |event|
        event.feature_on_welcome_screen = false
        event.save
      end        
      Festival.where(:feature_on_welcome_screen => true).load.each do |festival|
        festival.feature_on_welcome_screen = false
        festival.save
      end        
    end
    alias_method :create_event, :create
    def create
      reset_events if params[:festival][:feature_on_welcome_screen] == "1"
      create_event
    end
    alias_method :update_event, :update
    def update
      #logger.debug params
      reset_events if params[:festival][:feature_on_welcome_screen] == "1"
      update_event
    end
  end
  
  
end
