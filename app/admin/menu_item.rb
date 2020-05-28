ActiveAdmin.register MenuItem do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name_en, :name_de, :key, :page_id
  
  index do 
    selectable_column
      column :name_de
      column :name_en
      column :key
      column :page
    actions
  end
  
  config.filters = false
  
  show do
    attributes_table do
      row :name_de
      row :name_en
      row :key
      row :page
    end
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :name_de
        f.input :name_en
        f.input :key
        f.input :page, :include_blank => false
      end
      f.actions
  end
  
end
  