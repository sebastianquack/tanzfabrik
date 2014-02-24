ActiveAdmin.register Image do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :description, :license, :attachment
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  index do
    column "Image" do |image|
        link_to(image_tag(image.attachment.url(:thumb), :height => '50'), admin_image_path(image))
    end
    column :description
    column :license
    default_actions
  end

  show do
    attributes_table do
      row :description
      row :license
      row :image do
        image_tag(image.attachment.url)
      end
    end
    active_admin_comments
  end

# we need to use custom form, because formtastic file helper throws weird error
  form :partial => "form"

#  form :html => { :enctype => "multipart/form-data" } do |f|
#    f.inputs "Details" do
#      f.input :description
#      f.input :license
#    end
#    f.inputs "Image" do            
#      f.input :attachment, :as => :file # this is the error
#      f.file_field :attachment
#    end    
#    f.actions
#  end
  
end
