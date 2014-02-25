ActiveAdmin.register Location do

  menu false
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description, :address
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
    column :name
    column :description
    column :address
    default_actions
  end
  
  show do
    attributes_table do
      row :name
      row :description
      row :address
      row "Studios" do |location|
        location.studios.map { |s| (link_to s.name, admin_studio_path(s)) }.join(', ').html_safe
      end      
    end
    active_admin_comments
  end
  
    
    
  
end
