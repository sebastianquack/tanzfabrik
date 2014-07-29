ActiveAdmin.register Tag do

  menu false
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name_de, :name_en, :abbr_de, :abbr_en
  
  index do 
    selectable_column
      column :id
      column :name_de
      column :name_en
      column :abbr_de
      column :abbr_en      
      column "Events" do |e|
        e.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
      end
  
    actions
  end
  
  config.filters = false
  
  show do
    attributes_table do
      row :name_de
      row :name_en
      row :abbr_de
      row :abbr_en      
      row "Events" do |e|
        e.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
      end      
    end
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :name_de
        f.input :name_en
        f.input :abbr_de
        f.input :abbr_en        
      end
      f.actions
  end
  
end
  