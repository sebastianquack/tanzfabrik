ActiveAdmin.register Event do

  menu :priority => 1

  permit_params :title, :description, :type, :festival_ids => [], :person_ids => []

  index do 
    column "Festivals" do |event|
      event.festivals.map { |f| f.name }.join ', '
    end
    column :type
    column "People" do |event|
      event.people.map { |f| f.name }.join ', '
    end
    column :title
    actions
  end

  filter :title
  filter :type
  filter :festivals
  filter :people

  show do 
    attributes_table do
      row :title
      row :type
      row "People" do |event|
        event.people.map { |f| f.name }.join ', '
      end
      row "Festivals" do |event|
        event.festivals.map { |f| f.name }.join ', '
      end
      row :image do
        image_tag(event.image.url) if event.image.exists?
      end
    end
    active_admin_comments
  end


  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :type
      f.input :festivals, :as => :check_boxes
      f.input :people, :as => :check_boxes
    end

    f.actions
  end
  
  
end
