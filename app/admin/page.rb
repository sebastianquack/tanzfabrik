ActiveAdmin.register Page do

  menu :priority => 2

  breadcrumb do
    [ 
      #link_to("Menü", admin_menu_items_path),
      #request.params["id"] ? resource.slug : "Seiten"
    ]
    end
  
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :slug, :title_de, :content_de, :title_en, :content_en, :description_de, :description_en, :priority, :changefreq, :draft, :feature_on_welcome_screen, :feature_on_welcome_screen_urgent, :feature_on_welcome_screen_note_en, :feature_on_welcome_screen_note_de, :hide_download_links, :start_page_order, :project_menu_order, :show_in_project_menu, :disable_close, :section,
    :content_modules_attributes => [:id, :module_type, :headline, :order, :_destroy],
    :images_attributes => [:id, :description_de, :description_en, :license, :attachment, :_destroy],
    :downloads_attributes => [:id, :description_de, :description_en, :attachment_de, :attachment_en, :_destroy]
    
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  config.sort_order = 'updated_at_desc'
  config.filters = true

  filter :title_de
  filter :slug
  filter :content_de
  

  config.per_page = 100

  ActiveAdmin.register Page do

    member_action :create_content_module, method: :get do
      
      cm = ContentModule.create({
        page_id: resource.id,
        module_type: :content_element
      })
      redirect_to edit_admin_content_module_path(cm), notice: "Modul hinzugefügt!"
    end

    

  end

    

  
  index do

    selectable_column
    column :title_de, sortable: true do |page|
      h3 page.title_de, :class => "table_headline", "data-section" => page.section
    end
    column :number_of_content_modules do |page|
      page.content_modules.count
    end
    column :menu_items do |page|
      #page.menu_item
      #Activity.joins(:locations).where('locations.country = "Australia"')
      #MenuItem.joins(:page).where(page: { id: page.id })
      #MenuItem.find
      page.menu_items.each do |item|
        edit_admin_menu_item_url(item)
      end
    end    
    column "URL-Pfad" do |page|
      link_to page.slug, page_path(page)
    end
    #column :content_modules do |page|
    #   page.content_modules.map { |cm| cm.module_type.to_s + " " + cm.headline.to_s + " images: " + cm.images.length.to_s + " dl: " + cm.downloads.length.to_s }.join(', ')
    #end  

    column :updated_at
    
    #column :content do |page|
    #  page.content.html_safe if page.content
    #end
    #column Image.model_name.human do |page|
    #  page.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    #end
    
    actions
  end
  
  show do
    attributes_table do
      row "URL-Pfad" do |page|
        link_to page.slug, page
      end
      #row :title_de
      #row :title_en
      #row :content_de do |page|
      #  page.content_de.html_safe if page.content_de
      #end
      #row :content_en do |page|
      #  page.content_en.html_safe if page.content_en
      #end
      #row :description_de
      #row :description_en
      #row Image.model_name.human do |page|
      #  page.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      #end
      #row Download.model_name.human do |page|
      #  page.downloads.map { |d| link_to(d.description_de, d.attachment_de.url) + " " + link_to(d.description_en, d.attachment_en.url) }.join(', ').html_safe
      #end
      #row :hide_download_links
      row t(:draft) do |page|
         page.draft
      end

    end
  end

  form do |f|

    f.inputs "Details" do
      f.input :title_de
      f.input :title_en
      if f.object.id
       f.li link_to "Seite am Front-End anschauen", page_path(f.object)
      end
    end
    
    #f.inputs "Content" do
    #  f.input :content_de, :input_html => { :class => 'wysihtml5' }
    #  f.input :content_en, :input_html => { :class => 'wysihtml5' }
    #end

    if f.object.id
      f.inputs "Module" do
        
        f.has_many :content_modules, heading: false, sortable: :order do |f_f|
          f_f.template.render partial: "/content_modules/admin_preview", locals: {cm: f_f.object}
        end
        
        f.li link_to "Neues Modul hinzufügen", create_content_module_admin_page_path, :class => :button
      end
    else 
      f.inputs "Module" do
        f.li "Hinweis: Zum Anlegen von Modulen muss die Seite einmal gespeichert werden. Unten auf den Button 'Seite anlegen'."
      end
    end


    #f.inputs "Images" do
    #  f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        #f_f.inputs do
    #      f_f.input :description
    #      f_f.input :license
    #      if f_f.object.attachment.exists?
    #        f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
    #      else
    #        f_f.input :attachment, :as => :file, :required => false
    #      end
        #end
    #  end
    #end
    
    #f.inputs "Downloads" do
    #  f.has_many :downloads, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        #f_f.inputs do
    #      f_f.input :description_de
    #      f_f.input :description_en
    #      if f_f.object.attachment_de.exists?
    #        f_f.input :attachment_de, :as => :file, :required => false, :hint => link_to(f_f.object.attachment_de.original_filename, f_f.object.attachment.url)
    #      else
    #        f_f.input :attachment_de, :as => :file, :required => false
    #      end
    #      if f_f.object.attachment_en.exists?
    #        f_f.input :attachment_en, :as => :file, :required => false, :hint => link_to(f_f.object.attachment_en.original_filename, f_f.object.attachment_en.url)
    #      else
    #        f_f.input :attachment_en, :as => :file, :required => false
    #      end          
    #      #end
    #  end
    #  f.input :hide_download_links
    #end
    
    f.inputs "SEO" do
#      priority_hint = "Relative Wichtigkeit der Seite zwischen 0 (links, völlig unwichtig) und 1 (rechts, allerwichtigste Seite). Eingesteller Wert: "
#      f.input :priority, :as => :range, :in => 0..1, :step => 0.1, :input_html => {:onmousemove => "h = document.querySelector('#page_priority_input .inline-hints').innerText = '" + priority_hint + "' + this.value"}, :hint => (priority_hint + params[:priority].to_s)
      f.input :priority, :as => :select, :collection => [
        ['100% (Allerwichtigste Seite)',1],
        ['90% ',0.9],
        ['80% ',0.8],
        ['70% ',0.7],
        ['60% ',0.6],
        ['50%  (Durchschnittliche Wichtigkeit)',0.5],
        ['40% ',0.4],
        ['30% ',0.3],
        ['20% ',0.2],
        ['10% ',0.1],
        ['0%   (Gänzlich unwichtige Seite)',0],        
      ]
      f.input :changefreq, :label => "Frequency", :as => :select, :collection => ['daily','weekly','monthly','never']
      f.input :description_de, :input_html => { :maxlength => 156, :placeholder => auto_generate_description(f.object.content_de.to_s), :class => '' }
      f.input :description_en, :input_html => { :maxlength => 156, :placeholder => auto_generate_description(f.object.content_de.to_s), :class => '' }
    end
    
    f.inputs "Spezial" do 
     # f.input :feature_on_welcome_screen_urgent, :label => t(:feature_on_welcome_screen_urgent)
     # f.input :feature_on_welcome_screen, :label => t(:feature_on_welcome_screen)
     # f.input :start_page_order, :label => t(:start_page_order)
     # f.input :feature_on_welcome_screen_note_de, :label => t(:feature_on_welcome_screen_note) + " (DE)"
     # f.input :feature_on_welcome_screen_note_en, :label => t(:feature_on_welcome_screen_note) + " (EN)"
     # f.input :show_in_project_menu, :label => t(:show_in_project_menu)
     # f.input :project_menu_order, :label => t(:project_menu_order)
     # f.input :disable_close, :label => t(:disable_close)
      f.input :section, 
        :as => :select, 
        :include_blank => false, 
        :collection => [
          [t(:section_school), 'schule'], 
          [t(:section_stage), 'buehne'],
          [t(:section_factory), 'fabrik']
        ]
      f.input :draft, :label => t(:draft)
    end

      
    f.actions do
       f.action :submit
       li link_to "Zurück zur Menu-Übersicht", admin_menu_items_path, :class => :button
    end
  

  end
  
end
