ActiveAdmin.register Page do

  menu :priority => 0
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :title, :content
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  index do
    column :title
    column :slug
    column :content
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :title
    end
    f.inputs "Content" do
      f.input :content
    end
    f.actions
  end
  
  
end
