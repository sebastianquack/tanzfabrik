ActiveAdmin.register Event do

  menu :priority => 3

  permit_params :title_de, :description_de, :warning_de, :info_de, :info_en, :title_en, :description_en, :warning_en, :type_id,  
    :feature_on_welcome_screen, :price_regular, :price_reduced, :sequence, :facebook, :draft, :custom_sorting, :no_sign_up, :signup_url, 
    :rich_content_de, :rich_content_en, :info_rich_de, :info_rich_en, :credits_rich_de, :credits_rich_en,
    :ticket_link_url, :ticket_link_text_de, :ticket_link_text_en, :custom_type_de, :custom_type_en,
    :festival_ids => [], :person_ids => [],
    :event_details_attributes => [:id, :start_date, :end_date, :time, :duration, :studio_id, :custom_place, :repeat_mode_id, :_destroy, tag_ids: []],
    :people_attributes => [:id, :name, :_destroy],
    :person_events_attributes => [:id, :person_id, :event_id, :_destroy],
    :festival_events_attributes => [:id, :event_id, :festival_id, :_destroy],
    :images_attributes => [:id, :description_de, :description_en, :license, :attachment, :logo, :logo_panel, :_destroy]

  config.per_page = 100

  member_action :duplicate, method: :get do

    new_object = resource.dup # Duplicates main object without saving
    new_object.title_de = "[DUPLIKAT] " + resource.title_de
    new_object.title_en = "[DUPLICATE] " + resource.title_en     
    
    # duplicate associated records
    new_object.people = resource.people.dup
    new_object.festivals = resource.festivals.dup
    new_object.event_details << resource.event_details.collect { |detail| detail.dup }
    
    # reuploads a copy of each image
    new_images = []
    resource.images.each { |image| 
      new_image = image.dup 
      new_image.attachment = image.attachment
      new_images.push(new_image)
    }
    new_object.images = new_images

    if new_object.save
      # Duplicate the Action Text attributes manually
      new_object.rich_content_de = resource.rich_content_de.body.to_trix_html
      new_object.rich_content_en = resource.rich_content_en.body.to_trix_html
      new_object.info_rich_de = resource.info_rich_de.body.to_trix_html
      new_object.info_rich_en = resource.info_rich_en.body.to_trix_html
      new_object.credits_rich_de = resource.credits_rich_de.body.to_trix_html
      new_object.credits_rich_en = resource.credits_rich_en.body.to_trix_html
      new_object.save
      redirect_to admin_event_path(new_object)
    else
      redirect_to admin_event_path(resource), notice: "Could not duplicate."
    end
  end

    
  action_item :duplicate, :only => :show do
    link_to Event.model_name.human + " duplizieren", duplicate_admin_event_path(event)
  end

  index do 
    selectable_column
    #column EventDetail.model_name.human do |event|
    #  event.event_details.map do |ed|
    #    if ed.valid?
    #      div do
    #        div b ed.repeat_mode.description
    #        span ed.datetime_l(:default)
    #      end
    #    end
    #  end
    #end
    column :type do |event|
      event.display_type
    end
    #column Tag.model_name.human do |event|
    #  event.tags.map { |t| (link_to t.name, admin_tag_path(t)) }.join(', ').html_safe
    #end
    column Person.model_name.human do |event|
      event.people.map { |p| (link_to p.name, admin_person_path(p)) }.join(', ').html_safe
    end
    column :title_de
    #column t('activerecord.attributes.event.feature_on_welcome_screen_short'), :feature_on_welcome_screen
    column Image.model_name.human do |event|
      event.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    column Festival.model_name.human do |event|
      event.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
    end
    actions
  end

  filter :title_de
  filter :type
  filter :festivals
  filter :people, :collection => Person.ordered.all.map {
    |p| ["#{p.last_name}, #{p.first_name}", p.id]
  }
  
  show do 

    attributes_table do

      row "URL" do
        [:de, :en].each do |l|
          span link_to event_url(event, :locale => l), event_url(event, :locale => l), :target => "front"
          br
        end
      end

      row EventDetail.model_name.human do |event|
        event.event_details.each do |ed|
          if (ed.valid?)
            if ed.custom_place?
              span ed.custom_place
            else
              a (ed.studio.location.name + " " + ed.studio.name), :href => admin_studio_path(ed.studio)
            end
            span " (" + ed.repeat_mode.description + ")"
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
      
      row :rich_content_de do |event|
        div event.rich_content_de
      end
      row :rich_content_en do |event|
        div event.rich_content_en
      end

      row :info_rich_de do |event|
        event.info_rich_de
      end
      row :info_rich_en do |event|
        event.info_rich_en
      end
      
      unless event.facebook.nil? || event.facebook.empty?
        row "Facebook-Link" do
          a event.facebook, :href=>event.facebook, :target=>"_blank"
        end
      end
      row :price_regular do |price|
        number_to_currency price.price_regular
      end
      row :price_reduced do |price|
        number_to_currency price.price_reduced
      end       
      row :type
      row :custom_type_de
      row :custom_type_en

      #row Tag.model_name.human do |event|
      #  event.tags.map { |t| (link_to t.name, admin_tag_path(t)) }.join(', ').html_safe
      #end
      row Person.model_name.human do |event|
        event.people_sorted.map { |p| (link_to p.name, admin_person_path(p)) }.join(', ').html_safe
      end
      row t(:custom_sorting) do |event|
        t(event.custom_sorting)
      end
      row Festival.model_name.human do |event|
        event.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
      end
      row Image.model_name.human do |event|
        event.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      end
      #row t(:feature_on_welcome_screen) do |event|
      #  t(event.feature_on_welcome_screen)
      #end
      row t(:draft) do |event|
         t(event.draft)
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :type, :include_blank => false#, :hint => (link_to "Verwalten", admin_event_types_path)
      f.input :custom_type_de
      f.input :custom_type_en
    end

    f.inputs "Personen auswählen" do
      f.has_many :person_events, heading: false, :new_record => true, :allow_destroy => true do |p_f|
        #p_f.inputs do
          p_f.input :person, :collection => Person.order("lower(last_name) ASC"), :include_blank => false
        #end
      end
      f.input :custom_sorting
    end

    f.inputs "Basic info" do
      f.input :title_de, :as => :text, :input_html => { :class => 'autogrow', :rows => 2  }
      f.input :title_en, :as => :text, :input_html => { :class => 'autogrow', :rows => 2  }
      #f.input :sequence
      #f.input :description_de, :input_html => { :class => 'wysihtml5' }
      #f.input :description_en, :input_html => { :class => 'wysihtml5' }

      f.input :rich_content_de, :as => :action_text
      f.input :rich_content_en, :as => :action_text
      
      f.input :warning_de, :hint => "z.B. fällt heute aus!"
      f.input :warning_en, :hint => "e.g. cancelled!"

      f.input :info_rich_de, :as => :action_text
      f.input :info_rich_en, :as => :action_text
      
      f.input :credits_rich_de, :as => :action_text
      f.input :credits_rich_en, :as => :action_text
      
      f.inputs "Preise, Anmeldung, Tickets" do
        f.input :price_regular, :required => false
        f.input :price_reduced, :required => false 

        f.input :signup_url, :label => t(:signup_url)

        f.input :ticket_link_url, :label => t(:ticket_link_url)
        f.input :ticket_link_text_de, :placeholder => t(:ticket_link_text_default)
        f.input :ticket_link_text_en, :placeholder => t(:ticket_link_text_default)
      end

      f.inputs "Externe Links" do
        f.input :facebook, :required => false, :placeholder => "https://www.facebook.com/events/877048289058664/"
      end      
      

      
    end

    f.inputs Image.model_name.human do
      f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        #f_f.inputs do
          f_f.input :description_de
          f_f.input :description_en
          f_f.input :license
          f_f.input :logo
          f_f.input :logo_panel # see also: https://github.com/blocknotes/activeadmin_dynamic_fields
          f_f.input :link_href
          if f_f.object.attachment.exists?
            f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
          else
            f_f.input :attachment, :as => :file, :required => false
          end
        #end
      end
    end
    
    f.inputs "Zeiten,Orte,Attribute" do
      f.has_many :event_details, heading: false, :new_record => true, :allow_destroy => true do |et_f|
        #et_f.inputs do
          et_f.input :start_date, :include_blank => false, :start_year => 2014, :as => :datepicker
          et_f.input :repeat_mode, :include_blank => false, :collection => RepeatMode.order('id DESC').load.map {|r| [ r.description, r.id] }
          et_f.input :end_date, :include_blank => false, :start_year => 2014, :as => :datepicker

          et_f.input :time, :label => false, :include_blank => false, :as => :time_select
          et_f.input :duration, :hint => "Um für dieses Ereignis nur das Datum und keine Zeit anzuzeigen, Start auf 0:00 und Dauer auf 0 einstellen"
          
          et_f.input :studio, :include_blank => false, :collection => Studio.order(:location_id).load.map {|s| [ s.location.name + " " + s.name, s.id] }
          

          et_f.input :custom_place

          #et_f.inputs :tags, :class => 'no-legend' do
            et_f.input :tags, :label => false, :as => :check_boxes, :hint => (link_to Tag.model_name.human + "verwaltung", admin_tags_path)
          #end

        #end
      end
    end
        
    f.inputs "Festivals auswählen" do
      f.has_many :festival_events, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        #f_f.inputs do
          f_f.input :festival, :collection => Festival.order("lower(name_de) ASC"), :include_blank => false
        #end
      end
    end
    
    f.inputs "Spezial" do
      #f.input :feature_on_welcome_screen
      #f.input :no_sign_up, :label => t(:no_sign_up)      
      f.input :draft, :label => t(:draft)      
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
      # reset_events if params[:event][:feature_on_welcome_screen] == "1"
      create_event
      @event.reset_occurrences
      @event.start_date_cache = @event.start_date
      @event.end_date_cache = @event.end_date
      @event.save
    end
    alias_method :update_event, :update
    def update
      #logger.debug params
      # reset_events if params[:event][:feature_on_welcome_screen] == "1"
      update_event
      @event.reset_occurrences
      @event.start_date_cache = @event.start_date
      @event.end_date_cache = @event.end_date
      @event.save
    end
  end
  
  
end
