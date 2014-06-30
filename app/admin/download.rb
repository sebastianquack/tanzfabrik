ActiveAdmin.register Download do

  menu false
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :description_de, :description_en, :attachment
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
    column :description
    column "URL" do |download| 
      link_to download.attachment.original_filename, download.attachment.url
    end
    default_actions
  end


  form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs "Details" do
      f.input :description_de
      f.input :description_en
    end
    f.inputs "File" do         
      f.input :attachment, :as => :file, :required => false
    end    
    f.actions
  end
  
end
