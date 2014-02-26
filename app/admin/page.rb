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
    selectable_column
    column "URL" do |page|
      link_to page.slug, page
    end
    column :title
    column :content
    actions do |page|
        link_to "Wysiwig", '/editor/' + page.slug, :class => "member_link"
    end
  end

  filter :title
  filter :content
  
  show do
    attributes_table do
      row "URL" do |page|
        link_to page.slug, page
      end
      row :title
      row :content
    end
    active_admin_comments
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
