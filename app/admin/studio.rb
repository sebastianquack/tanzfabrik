ActiveAdmin.register Studio do

  menu :priority => 5
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description, :location_id, :rentable, :image
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
    column "Image" do |studio|
      image_tag(studio.image.url) if studio.image.exists?
    end
    default_actions
  end
  
  filter :location
    
  show do
    attributes_table do
      row :location
      row :name
      row :description
      row :image do
        image_tag(studio.image.url) if studio.image.exists?
      end
    end
    active_admin_comments
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs "Location" do
        f.input :location, :include_blank => false, :hint => (link_to "Manage locations", admin_locations_path)
      end
      f.inputs "Details" do
        f.input :name
        f.input :description
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
