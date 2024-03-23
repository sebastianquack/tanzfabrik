ActiveAdmin.register User do

  menu :priority => 10
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :first_name, :last_name, :email, :phone_number, :billing_address
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
    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :billing_address
    actions
  end
  
  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone_number
      row :billing_address
      row :bio
      row :is_krk_registered
      row :website
      row :preferred_language
      row :is_course_newsletter_registered
      row :is_workshop_newsletter_registered
    end
  end
  
    
    
  
end
