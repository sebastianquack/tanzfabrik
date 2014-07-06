ActiveAdmin.register Image do

  menu :priority => 10
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :description, :license, :attachment, :studio_id, :person_id, :event_id, :festival_id, :show_on_welcome_screen
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
    column "Image" do |image|
        link_to image_tag(image.attachment.url(:thumb), :height => '50'), admin_image_path(image)
    end
    column :description
    column :license
    column :show_on_welcome_screen
    default_actions
  end

  filter :description
  filter :show_on_welcome_screen

  config.per_page = 100

  show do
    attributes_table do
      row :description
      row :license
      row :show_on_welcome_screen
      row :image do
        image_tag(image.attachment.url)
      end
    end
    active_admin_comments
  end

# we might want to use custom form, because formtastic file helper throws weird error
  #form :partial => "form"

  form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs "Details" do
      f.input :description
      f.input :license
      f.input :show_on_welcome_screen
    end
    f.inputs "Image" do         
      f.input :attachment, :as => :file, :required => false
    end    
    f.actions
  end
  
end
