ActiveAdmin.register Download do

  menu false
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :description_de, :description_en, :attachment_de, :attachment_en
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
      link_to download.attachment_de.original_filename, download.attachment_de.url
      link_to download.attachment_en.original_filename, download.attachment_en.url
    end
    default_actions
  end


  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :description_de
      f.input :description_en
    end
    f.inputs "File" do         
      f.input :attachment_de, :as => :file, :required => false
      f.input :attachment_en, :as => :file, :required => false
    end    
    f.actions
  end
  
end
