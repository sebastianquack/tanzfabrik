ActiveAdmin.register MenuItem do

  menu :priority => -1

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name_en, :name_de, :key, :page_id, :position, :anchor

  # disable authentication for ajax sort request
  #skip_before_filter :verify_authenticity_token, :only => :sort

  config.batch_actions = false
  
  sortable tree: true
    
  index :as => :sortable do
    label :name_de
    actions defaults: true do |mi|
      link_to "Seite bearbeiten", edit_admin_page_path(mi.page), class: "member_link" if mi.page
    end
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
        f.input :position
        f.input :page, :include_blank => true, :collection => Page.all.order(:slug).collect {|page| [page.slug, page.id] }
        f.input :anchor
      end
      f.actions
  end
  
end
  