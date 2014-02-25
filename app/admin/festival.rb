ActiveAdmin.register Festival do

  menu :priority => 2

  permit_params :name, :description, :event_ids => []
  
  index do
    column :name
    column :description
    column "Events" do |festival|
      festival.events.map { |e| e.title }.join ', '
    end
    
    column "Image" do |festival|
        link_to image_tag(festival.image.url(:thumb), :height => '50'), admin_image_path(festival) if festival.image.exists?
    end
    default_actions
  end
  
  filter :name
  filter :description
    
  show do
    attributes_table do
      row :name
      row :description
      row "Events" do |festival|
        festival.events.map { |e| e.title }.join ', '
      end      
      row :image do
        image_tag(festival.image.url) if festival.image.exists?
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :events, :as => :check_boxes
    end

    #f.inputs do
    #  f.has_many :events, :allow_destroy => true, :heading => 'Events', :new_record => true do |ef|
    #    ef.input :title
    #  end
    #end

    #f.inputs "Events" do
    #  f.has_many :festivals_events do |ef|
    #    if !ef.object.nil?
          # show the destroy checkbox only if it is an existing record
    #      ef.input :_destroy, :as => :boolean, :label => "Destroy?"
    #    end
    #    ef.input :event
    #  end
    #end
    
    if f.object.image.exists?
      f.inputs "Current image" do     
        f.template.content_tag(:li) do
          f.template.image_tag(f.object.image.url(:thumb))
        end
      end
    end
    
    f.inputs "New image" do     
      # use regular rails helper instead of formtastic, avoid weird error
      f.template.content_tag(:li) do
        f.file_field :image
      end
    end    
    
    
    f.actions
  end
  
  
end
