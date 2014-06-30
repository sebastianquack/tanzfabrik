ActiveAdmin.register Festival do

  menu :priority => 2

  permit_params :name_de, :description_de, :name_en, :description_en, :event_ids => [], :images_attributes => [:id, :description, :license, :attachment, :_destroy]
  
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
      row "images" do |festival|
        festival.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
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
    
    
    f.actions
  end
  
  
end
