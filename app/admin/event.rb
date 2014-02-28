ActiveAdmin.register Event do

  menu :priority => 1

  permit_params :title, :description, :warning, :type_id, :image, 
    :festival_ids => [], :person_ids => [], 
    event_details_attributes: [:id, :start_date, :end_date, :time, :duration, :studio_id, :repeat_mode_id, :_destroy],
    people_attributes: [:id, :name, :_destroy],
    person_events_attributes: [:id, :person_id, :event_id, :_destroy],
    festival_events_attributes: [:id, :event_id, :festival_id, :_destroy]

  index do 
    selectable_column
    column "Details" do |event|
      event.event_details.map { |t| t.datetime_l(:default) }.join('<br>').html_safe
    end

    column "Festivals" do |event|
      event.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
    end
    column :type
    column "People" do |event|
      event.people.map { |p| (link_to p.name, admin_person_path(p)) }.join(', ').html_safe
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
      row "Details" do |event|
        event.event_details.each do |ed|
          a (ed.studio.location.name + " " + ed.studio.name), :href => admin_studio_path(ed.studio)
          ul do
            ed.occurrences.each do |oc|
              li span(l oc, :format => :default)
            end  
          end
        end    
      end

      row :title
      row :description
      row :type
      row "People" do |event|
        event.people.map { |p| (link_to p.name, admin_person_path(p)) }.join(', ').html_safe
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
    f.inputs "Basic Info" do
      f.input :title
      f.input :description
      f.input :warning
      f.input :type, :include_blank => false, :hint => (link_to "Manage Event Types", admin_event_types_path)
      #f.input :festivals, :as => :check_boxes
      #f.input :people, :as => :check_boxes
    end

    f.inputs "Festivals auswählen" do
      f.has_many :festival_events, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        f_f.inputs do
          f_f.input :festival, :include_blank => false
        end
      end
    end

    f.inputs "Personen auswählen" do
      f.has_many :person_events, heading: false, :new_record => true, :allow_destroy => true do |p_f|
        p_f.inputs do
          p_f.input :person, :include_blank => false
        end
      end
    end

    f.inputs "Event Details" do
      f.has_many :event_details, heading: false, :new_record => true, :allow_destroy => true do |et_f|
        et_f.inputs do
          et_f.input :start_date, :include_blank => false, :start_year => 2014, :as => :datepicker
          et_f.input :repeat_mode, :include_blank => false, :collection => RepeatMode.order('id DESC').load.map {|r| [ r.description, r.id] }, :hint => (link_to "Manage Repeat Modes", admin_repeat_modes_path)
          et_f.input :end_date, :include_blank => false, :start_year => 2014, :as => :datepicker

          et_f.input :time, :label => false, :include_blank => false, :as => :time_select
          et_f.input :duration
          
          et_f.input :studio, :include_blank => false, :collection => Studio.order(:location_id).load.map {|s| [ s.location.name + " " + s.name, s.id] }
          

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
