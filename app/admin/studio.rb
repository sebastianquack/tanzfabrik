ActiveAdmin.register Studio do

  menu :priority => 5
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description_de, :description_en, :location_id, :rentable, :images_attributes => [:id, :description, :license, :attachment, :_destroy]
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  index do
    selectable_column
    column :location
    column :name
    column :description
    column "images" do |page|
      page.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    default_actions
  end
  
  filter :location
  
  config.per_page = 100
    
  show do
    attributes_table do
      row :location
      row :name
      row :description_de do |studio|
        studio.description_de.html_safe if studio.description_de
      end
      row :description_en do |studio|
        studio.description_en.html_safe if studio.description_en
      end
      row "images" do |page|
        page.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      end
    end
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs "Location" do
        f.input :location, :include_blank => false, :hint => (link_to "Manage locations", admin_locations_path)
      end
      f.inputs "Details" do
        f.input :name
        f.input :description_de#, as: :wysihtml5, commands: [ :bold, :italic, :underline, :small, :link ], blocks: []
        f.input :description_en#, as: :wysihtml5, commands: [ :bold, :italic, :underline, :small, :link ], blocks: []
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
