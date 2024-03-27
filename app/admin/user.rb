ActiveAdmin.register User do

  menu :priority => 10
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :first_name, :last_name, :email, :phone_number, :billing_address, :bio, :is_krk_registered, :website, :preferred_language, :is_course_newsletter_registered, :is_workshop_newsletter_registered
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
  
  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone_number
      f.input :billing_address
      f.input :bio
      f.input :is_krk_registered
      f.input :website
      f.input :preferred_language
      f.input :is_course_newsletter_registered
      f.input :is_workshop_newsletter_registered
    end
    f.actions
  end
    
  
end
