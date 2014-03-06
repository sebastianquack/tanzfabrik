ActiveAdmin.register EventType do

  menu false
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name_de, :name_en
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
      column :id
      column :name
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
      row "Events" do |e|
        e.events.map { |e| (link_to e.title, admin_event_path(e)) }.join(', ').html_safe
      end      
    end
    active_admin_comments
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :name_de
        f.input :name_en
      end
      f.actions
  end
  
  
  
end
