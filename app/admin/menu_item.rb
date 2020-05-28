ActiveAdmin.register MenuItem do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name_en, :name_de, :key, :page_id, :position

  # disable authentication for ajax sort request
  skip_before_filter :verify_authenticity_token, :only => :sort
  
  sortable tree: true
    
  index :as => :sortable do
    label :name_de
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
  