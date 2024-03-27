ActiveAdmin.register BookingPermissionRequest do

  menu :priority => 11
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :type, :status
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
    column :permission_type
    column :user
    column :description
    column :status
    actions
  end
  
  show do
    attributes_table do
      row :permission_type
      row :user
      row :description do |resource|
        simple_format(resource.description)
      end
      row :status
    end
  end
end