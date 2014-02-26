ActiveAdmin.register Event do

  menu :priority => 1

  permit_params :title, :description, :type_id, :image, :festival_ids => [], :person_ids => [], event_times_attributes: [:id, :datetime, :duration, :studio_id, :_destroy]

  index do 
    selectable_column
    column "Times" do |event|
      event.event_times.map { |t| t.datetime.to_s }.join('<br>').html_safe
    end

    column "Festivals" do |event|
      event.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
    end
    column :type
    column "People" do |event|
      event.people.map { |p| (link_to p.name, admin_person_path(p)) }.join.html_safe
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
      row "Times" do |event|
        event.event_times.map { |t| t.datetime.to_s + ", " + link_to(t.studio.location.name + " " + t.studio.name, admin_studio_path(t.studio)) + ", " + t.duration.to_s + " Minuten" }.join('<br>').html_safe
      end

      row :title
      row :type
      row "People" do |event|
        event.people.map { |p| (link_to p.name, admin_person_path(p)) }.join.html_safe
      end
      row "Festivals" do |event|
        event.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
      end
      row :image do
        image_tag(event.image.url) if event.image.exists?
      end
    end
    active_admin_comments
  end


  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description
      f.input :type, :include_blank => false, :hint => (link_to "Manage Event Types", admin_event_types_path)
      f.input :festivals, :as => :check_boxes
      f.input :people, :as => :check_boxes
    end

    f.inputs "Event times" do
      f.has_many :event_times, heading: false, :new_record => true, :allow_destroy => true do |et_f|
        et_f.inputs do
          et_f.input :datetime, :label => false, :include_blank => false, :start_year => 2014  
          et_f.input :duration
          et_f.input :studio, :include_blank => false, :collection => Studio.order(:location_id).all.map {|s| [ s.location.name + " " + s.name, s.id] }
        end
      end
    end
    
    if f.object.image.exists?
      f.inputs "Current image" do     
        f.template.content_tag(:li) do
          f.template.image_tag(f.object.image.url(:thumb))
        end
      end
    end
    
    f.inputs "New image" do     
      # use regular rails helper instead of formtastic, avoid weird error
      f.template.content_tag(:li) do
        f.file_field :image
      end
    end    
    
    f.actions
  end
  
  
end
