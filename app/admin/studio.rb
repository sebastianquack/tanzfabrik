ActiveAdmin.register Studio do

  menu :priority => 6
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description_de, :description_en, :rich_content_de, :rich_content_en, :location_id, :rentable, :images_attributes => [:id, :description, :license, :attachment, :_destroy]
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
    column :description do |studio|
      div studio.rich_content_de
    end
    column "images" do |page|
      page.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    actions
  end
  
  filter :location
  
  config.per_page = 100
    
  show do
    attributes_table do
      row :location
      row :name
      #row :description_de do |studio|
      #  studio.description_de.html_safe if studio.description_de
      #end
      #row :description_en do |studio|
      #  studio.description_en.html_safe if studio.description_en
      #end
      row :rich_content_de do |person|
        div person.rich_content_de
      end
      row :rich_content_en do |person|
        div person.rich_content_en
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
        #f.input :description_de, :input_html => { :class => 'wysihtml5' }
        #f.input :description_en, :input_html => { :class => 'wysihtml5' }
        f.input :rich_content_de, :as => :action_text
        f.input :rich_content_en, :as => :action_text

      end
      f.inputs "Images" do
        f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
          #f_f.inputs do
            f_f.input :description
            f_f.input :license
            if f_f.object.attachment.exists?
              f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
            else
              f_f.input :attachment, :as => :file, :required => false
            end
          #end
        end
      end
    
      f.actions
  end
        
end
