ActiveAdmin.register Event do

  menu :priority => 1

  permit_params :title_de, :description_de, :warning_de, :info_de, :info_en, :title_en, :description_en, :warning_en, :type_id, :feature_on_welcome_screen, :price_regular, :price_reduced,
    :festival_ids => [], :person_ids => [],
    :event_details_attributes => [:id, :start_date, :end_date, :time, :duration, :studio_id, :repeat_mode_id, :_destroy, tag_ids: []],
    :people_attributes => [:id, :name, :_destroy],
    :person_events_attributes => [:id, :person_id, :event_id, :_destroy],
    :festival_events_attributes => [:id, :event_id, :festival_id, :_destroy],
    :images_attributes => [:id, :description, :license, :attachment, :_destroy]

  config.per_page = 100

  member_action :clone, method: :get do
    @resource = resource.dup
    @resource.people = resource.people.dup
    #@resource.event_details = resource.event_details.dup
    #@resource.images << resource.images
    #@resource.festivals << resource.festivals.dup
    render :new, layout: false
  end

  action_item :only => :show do
    link_to(Event.model_name.human + " duplizieren", clone_admin_event_path(id: event.id))
  end

  index do 
    selectable_column
    column EventDetail.model_name.human do |event|
      event.event_details.map { |t| t.datetime_l(:default) }.join('<br>').html_safe if event.event_details.all? { |ed| ed.valid? }
    end
    column Image.model_name.human do |event|
      event.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    column Festival.model_name.human do |event|
      event.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
    end
    column :type
    #column Tag.model_name.human do |event|
    #  event.tags.map { |t| (link_to t.name, admin_tag_path(t)) }.join(', ').html_safe
    #end
    column Person.model_name.human do |event|
      event.people.map { |p| (link_to p.name, admin_person_path(p)) }.join(', ').html_safe
    end
    column :title
    column t('activerecord.attributes.event.feature_on_welcome_screen_short'), :feature_on_welcome_screen
    actions
  end

  filter :title_de
  filter :type
  filter :festivals
  filter :people
  filter :feature_on_welcome_screen

  show do 
    attributes_table do
      row EventDetail.model_name.human do |event|
        event.event_details.each do |ed|
          if (ed.valid?)
            a (ed.studio.location.name + " " + ed.studio.name), :href => admin_studio_path(ed.studio)
            ul do
              ed.occurrences.each do |oc|
                li span(l oc, :format => :default)
              end  
            end
          end
        end    
      end

      row :title_de
      row :title_en
      row :description_de do |event|
        event.description_de.html_safe if event.description_de
      end
      row :description_en do |event|
        event.description_en.html_safe if event.description_en
      end
      row :info_de do |event|
        event.info_de.html_safe if event.info_de
      end
      row :info_en do |event|
        event.info_en.html_safe if event.info_en
      end
      row :price_regular do |price|
        number_to_currency price.price_regular
      end
      row :price_reduced do |price|
        number_to_currency price.price_reduced
      end       
      row :type
      #row Tag.model_name.human do |event|
      #  event.tags.map { |t| (link_to t.name, admin_tag_path(t)) }.join(', ').html_safe
      #end
      row Person.model_name.human do |event|
        event.people.map { |p| (link_to p.name, admin_person_path(p)) }.join(', ').html_safe
      end
      row Festival.model_name.human do |event|
        event.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
      end
      row Image.model_name.human do |event|
        event.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      end
      row :feature_on_welcome_screen
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Typ" do
      f.input :type, :include_blank => false, :hint => (link_to "Verwalten", admin_event_types_path)
    end

    f.inputs "Personen auswählen" do
      f.has_many :person_events, heading: false, :new_record => true, :allow_destroy => true do |p_f|
        p_f.inputs do
          p_f.input :person, :include_blank => false
        end
      end
    end

    f.inputs "Basic info" do
      f.input :title_de, :as => :text, :input_html => { :class => 'autogrow', :rows => 2  }
      f.input :title_en, :as => :text, :input_html => { :class => 'autogrow', :rows => 2  }
      f.input :description_de, :input_html => { :class => 'wysihtml5' }
      f.input :description_en, :input_html => { :class => 'wysihtml5' }
      f.input :info_de, :input_html => { :class => 'wysihtml5 wysihtml5-notoolbar' }
      f.input :info_en, :input_html => { :class => 'wysihtml5 wysihtml5-notoolbar' }
      f.input :warning_de
      f.input :warning_en
      f.inputs :prices, :title => "Preise (für Workshops)" do
        f.input :price_regular, :required => false
        f.input :price_reduced, :required => false 
      end
    end

    f.inputs Image.model_name.human do
      f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        f_f.inputs do
          f_f.input :description
          f_f.input :license
          if f_f.object.attachment.exists?
            f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
          else
            f_f.input :attachment, :as => :file, :required => false
          end
        end
      end
    end
    
    f.inputs "Zeiten,Orte,Attribute" do
      f.has_many :event_details, heading: false, :new_record => true, :allow_destroy => true do |et_f|
        et_f.inputs do
          et_f.input :start_date, :include_blank => false, :start_year => 2014, :as => :datepicker
          et_f.input :repeat_mode, :include_blank => false, :collection => RepeatMode.order('id DESC').load.map {|r| [ r.description, r.id] }, :hint => (link_to "Manage Repeat Modes", admin_repeat_modes_path)
          et_f.input :end_date, :include_blank => false, :start_year => 2014, :as => :datepicker

          et_f.input :time, :label => false, :include_blank => false, :as => :time_select
          et_f.input :duration
          
          et_f.input :studio, :include_blank => false, :collection => Studio.order(:location_id).load.map {|s| [ s.location.name + " " + s.name, s.id] }
          
          et_f.inputs :class => 'no-legend' do
            et_f.input :tags, :as => :check_boxes, :hint => (link_to Tag.model_name.human + "verwaltung", admin_tags_path)
          end

        end
      end
    end
        
    f.inputs "Festivals auswählen" do
      f.has_many :festival_events, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        f_f.inputs do
          f_f.input :festival, :include_blank => false
        end
      end
    end
    
    f.inputs "Special" do
      f.input :feature_on_welcome_screen
    end
    
    f.actions
  end
  
  controller do
    def reset_events
      Event.where(:feature_on_welcome_screen => true).load.each do |event|
        event.feature_on_welcome_screen = false
        event.save
      end        
      Festival.where(:feature_on_welcome_screen => true).load.each do |festival|
        festival.feature_on_welcome_screen = false
        festival.save
      end        
    end
    alias_method :create_event, :create
    def create
      reset_events if params[:event][:feature_on_welcome_screen] == "1"
      create_event
    end
    alias_method :update_event, :update
    def update
      #logger.debug params
      reset_events if params[:event][:feature_on_welcome_screen] == "1"
      update_event
    end
  end
  
  
end
