ActiveAdmin.register TextItem do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :content_de, :content_en
  
  index do 
    selectable_column
      column :name
      column :content_de
      column :content_en  
    actions
  end
  
  config.filters = false
  
  show do
    attributes_table do
      row :name
      row :content_de
      row :content_en
    end
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :content_de
        f.input :content_en
      end
      f.actions
  end
  
end
  