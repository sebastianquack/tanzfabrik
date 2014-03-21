ActiveAdmin.register Festival do

  menu :priority => 2

  permit_params :name_de, :description_de, :name_en, :description_en, :image, :event_ids => []
  
  index do
    selectable_column
    column :name
    column :description
    column "Events" do |festival|
      festival.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
    end
    
    column "Image" do |festival|
      image_tag(festival.image.url) if festival.image.exists?
    end
    default_actions
  end
  
  filter :name_de
  filter :description_de
   
  config.per_page = 10
    
  show do
    attributes_table do
      row :name
      row :description
      row "Events" do |festival|
        festival.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
      end      
      row :image do
        image_tag(festival.image.url) if festival.image.exists?
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
