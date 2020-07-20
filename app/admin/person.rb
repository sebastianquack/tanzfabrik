ActiveAdmin.register Person do

  menu :priority => 5  

  permit_params :id, :first_name, :last_name, :bio_de, :bio_en, :role, :dance_intensive, :draft, :tags, :event_ids => [], :images_attributes => [:id, :description, :license, :attachment, :_destroy]

  config.sort_order = 'last_name_asc'

  index do
    selectable_column
    column :first_name
    column :last_name
    column :tags
    column :events do |person|
        person.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
    end
    column :images do |person|
      person.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    actions
  end
  
  filter :first_name
  filter :last_name
  filter :tags
  filter :events
  
  config.per_page = 100
  
  show do
    attributes_table do
      row :first_name
      row :last_name
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
#      row t(:draft) do |person|
#        person.draft
#      end
    end
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :first_name
        f.input :last_name
        #f.input :dance_intensive        
        f.input :tags
        #f.input :role
        f.input :bio_de
        f.input :bio_en
        #f.input :events, :as => :check_boxes
        
      end
      f.inputs "Images" do
        f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
          #f_f.inputs do
            f_f.input :description
            f_f.input :license
            if f_f.object.attachment.exists?
              f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.link_to(image_tag(f_f.object.attachment.url(:thumb)), f_f.object.attachment.url)
            else
              f_f.input :attachment, :as => :file, :required => false
            end
          #end
        end
      end
#      f.inputs "Spezial" do 
#        f.input :draft, :label => t(:draft)      
#      end
      
      f.actions
  end


  
end
