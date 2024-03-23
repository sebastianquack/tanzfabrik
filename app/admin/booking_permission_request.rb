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
    column :type
    column :user
    column :description
    column :status
    actions
  end
  
  show do
    attributes_table do
      row :type
      row :user
      row :description
      row :status
    end
  end
end
