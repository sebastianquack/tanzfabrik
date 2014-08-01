ActiveAdmin.register Person do

  menu :priority => 3  

  permit_params :id, :name, :bio_de, :bio_en, :role, :dance_intensive, :event_ids => [], :images_attributes => [:id, :description, :license, :attachment, :_destroy]

  index do
    selectable_column
    column :name
    #column :role
    column :events do |person|
        person.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
    end
    column :images do |person|
      person.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    default_actions
  end
  
  filter :name
  filter :role
  filter :events
  
  config.per_page = 100
  
  show do
    attributes_table do
      row :name
      #row :role
      row :dance_intensive
      row :events do |person|
        person.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
      end      
      row :bio_de do |bio|
        bio.bio_de.html_safe if bio.bio_de
      end
      row :bio_en do |bio|
        bio.bio_en.html_safe if bio.bio_en
      end
      row :images do |person|
        person.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      end
    end
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs "Details" do
        f.input :name
        f.input :dance_intensive        
        #f.input :role
        f.input :bio_de, :input_html => { :class => 'wysihtml5' }
        f.input :bio_en, :input_html => { :class => 'wysihtml5' }
        #f.input :events, :as => :check_boxes
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
