ActiveAdmin.register ContentModule do

  menu false

  breadcrumb do
    [ 
      #link_to("Menü", admin_menu_items_path),
      request.params["id"] ? link_to(resource.page.slug, edit_admin_page_path(resource.page)) : nil,
      request.params["id"] ? "Modul #" + request.params["id"] : nil
    ]
  end

  #  t.string "module_type"
  #  t.integer "page_id"
  #  t.string "style_option"
  #  t.string "section"
  #  t.string "super"
  #  t.string "headline"
  #  t.string "sub"
  #  t.text "main_text"
  #  t.text "main_text_col2"
  #  t.text "special_text"


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :module_type, :style_option, :section, :draft, :headline_de, :headline_en, :super_de, :super_en, :sub_de, :sub_en, :special_text_de, :special_text_en, :rich_content_1_de, :rich_content_1_en, :rich_content_2_de, :rich_content_2_en, :custom_html_de, :custom_html_en, :parameter, :locale,
  :link_href_de, :link_href_en, :link_title_de, :link_title_en,
  :images_attributes => [:id, :description, :license, :attachment, :_destroy],
  :downloads_attributes => [:id, :description_de, :description_en, :attachment_de, :attachment_en, :_destroy]


  ActiveAdmin.register ContentModule do
      member_action :delete_content_module, method: :get do
        ContentModule.delete(resource.id)
        redirect_to edit_admin_page_path(resource.page), notice: "Modul gelöscht!"
      end

      member_action :save_and_preview, method: :post do      
        ContentModule.update(resource.id, permitted_params)
        redirect_to admin_content_module_path
      end

  end

  controller do
    def update
      update! do |format|
        format.html { 
          if params[:preview]
            redirect_to admin_content_module_path, notice: "Modul gespeichert!" 
          else
            redirect_to edit_admin_content_module_path, notice: "Modul gespeichert!" 
          end
        }
      end
    end
  end

   # todo add all

  index do 
    selectable_column
    column "page" do |content_module| 
      content_module.page.title_de
    end
    column :module_type
    column :style_option
    actions
  end
  
  show do
    attributes_table do
      row "Seite" do |content_module| 
        content_module.page.title_de.to_s
      end
      row :module_type do |content_module|
        t("content_modules.module_types." + content_module.module_type.to_s)
      end
      row :style_option do |content_module|
        t("content_modules.style_options." + content_module.style_option.to_s)
      end
      row :section do |content_module|
        t("content_modules.sections." + content_module.section.to_s)
      end      
      row "weiter zu" do |content_module|
        ul do
          li link_to "Modul bearbeiten", edit_admin_content_module_url(content_module.id)
          li link_to "Seite bearbeiten", edit_admin_page_url(content_module.page.id)
          li link_to "Seite am Front-End anschauen", content_module.page
          if content_module.module_type == "festival_vorschau" || content_module.module_type == "festival_programm"
            li link_to "Festival bearbeiten", edit_admin_festival_url(content_module.parameter)
          end
        end
      end
      row "Vorschau" do |content_module|
        #render partial: "/content_modules/index", locals: {content_module: content_module}
        render partial: "/content_modules/admin_preview", locals: {cm: content_module}
      end
      row :draft
    end
  end

  
  form do |f|

      #para CM_CONFIG[f.object.module_type].inspect

      default_module_type = "page_intro"

      type = f.object.module_type
      Rails.logger.info "type-foo"
      Rails.logger.info type
      if type == "" || !type || !CM_CONFIG[type]
        type = default_module_type
      end

      style_options = CM_CONFIG[type]["style-options"] ? CM_CONFIG[type]["style-options"].map { |a| [ t("content_modules.style_options." + a), a ] } : []
      sections = CM_CONFIG[type]["sections"] ? CM_CONFIG[type]["sections"].map { |a| [ t("content_modules.sections." + a), a ] } : []

      def make_input(f, mtype, field, active, action_text, hint="")    
        
        unless action_text
          # special types
          if field == "parameter" && (mtype == "festival_programm" || mtype == "festival_vorschau")
            f.input field, :as => :select, :collection => Festival.order("name_de").all, :include_blank => false
          elsif field == "parameter" && (mtype == "kursplan")
            f.input field, :as => :select, :collection => Location.all.map {|l| [l.name, l.name]}, :include_blank => false
          elsif field == "parameter" && (mtype == "studio")
            f.input field, :as => :select, :collection => Studio.all.map {|s| [s.location.name + " " + s.name, s.id]}, :include_blank => false            
          elsif field == "parameter" && (mtype == "people_gallery")
            f.input field, :label => t("attributes.person.tags", scope: [:activerecord]), :hint => ("<span class='people_tags_list'><u>Verwendete Tags</u><br /><span>" + Person.get_all_tags.join("</span><br /><span>") + "</span></span>").html_safe
          else
            return f.input field, :wrapper_html => { 
              :class => active ? "cm-field-active" : "cm-field-hidden"
            },
            :hint => hint
          end
        else 
          return f.input field, :wrapper_html => { 
            :class => active ? "cm-field-active" : "cm-field-hidden" 
          }, :as => :action_text, :hint => hint
        end        
      end 

      def content_module_input(f, mtype, field, action_text=false, localise=true, hint="")
        active = CM_CONFIG[mtype]["form-fields"] ? CM_CONFIG[mtype]["form-fields"].include?(field) : false
        if localise
          return [
            make_input(f, mtype, field + "_de", active, action_text, hint),
            make_input(f, mtype, field + "_en", active, action_text, hint),
            hr
          ]
        else
          return [
              make_input(f, mtype, field, active, action_text),
              hr
          ]
        end
      end

      f.inputs "Meta" do
        f.input :module_type, :as => :select, :collection => CM_CONFIG.keys.map{|k| [t("content_modules.module_types." + k), k]}, :include_blank => false, selected: f.object.module_type || default_module_type
        if style_options.length > 0
          f.input :style_option, :as => :select, :collection => style_options, :include_blank => false
        end
        if sections.length > 0
          f.input :section, :as => :select, :collection => sections, :include_blank => false
        end
        f.input :draft, :label => t(:draft)
        f.li link_to "Modul löschen", delete_content_module_admin_content_module_path, :class => "button active-admin-delete-content-module"
      end
      
      f.inputs "Content" do
        div "Nutzungsbeispiel(e)", class: "module_hint" do 
          img src: '/module_hints/' + type + '.png' # should be done with image_pack_tag but couldn't make it work!!
        end
        content_module_input f, type, "super"
        content_module_input f, type, "headline", false, true, "Bitte mit \"\\\" mögliche  Worttrennungen innerhalb von Wörtern markieren, z.B. \"Wort\\trennung\"."
        content_module_input f, type, "sub"
        content_module_input f, type, "special_text"
        content_module_input f, type, "parameter", false, false
        content_module_input f, type, "rich_content_1", true
        content_module_input f, type, "rich_content_2", true
        content_module_input f, type, "link_title", false, true
        content_module_input f, type, "link_href", false, true
        content_module_input f, type, "custom_html"
      end

      if !CM_CONFIG[type].has_key? "images" || CM_CONFIG[type]["images"] != false
        f.inputs "Images", :id => "active_admin_cm_images" do
          f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
            f_f.input :description
            f_f.input :license
            if type == "slideshow"
              f_f.input :super_de
              f_f.input :super_en
              f_f.input :headline_de
              f_f.input :headline_en
              f_f.input :rich_content_1_de, :as => :action_text
              f_f.input :rich_content_1_en, :as => :action_text
              f_f.input :link_title_de
              f_f.input :link_title_en
              f_f.input :link_href_de
              f_f.input :link_href_en
            end
            if f_f.object.attachment.exists?
              f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
            else
              f_f.input :attachment, :as => :file, :required => false
            end
          end
        end
      end

      if !CM_CONFIG[type].has_key? "downloads" || CM_CONFIG[type]["downloads"] != false
        f.inputs "Downloads", :id => "active_admin_cm_downloads" do
          f.has_many :downloads, heading: false, :new_record => true, :allow_destroy => true do |f_f|
            f_f.input :description_de
            f_f.input :description_en
            if f_f.object.attachment_de.exists?
              f_f.input :attachment_de, :as => :file, :required => false, :hint => link_to(f_f.object.attachment_de.original_filename, f_f.object.attachment.url)
            else
              f_f.input :attachment_de, :as => :file, :required => false
            end
            if f_f.object.attachment_en.exists?
              f_f.input :attachment_en, :as => :file, :required => false, :hint => link_to(f_f.object.attachment_en.original_filename, f_f.object.attachment_en.url)
            else
              f_f.input :attachment_en, :as => :file, :required => false
            end          
          end
        end
      end


      f.actions do
        f.action :submit
        f.action :submit, :as => :button, label: 'Speichern und Vorschau', button_html: {name: 'preview', value: 'preview'}
        li link_to "Zurück zur Seite", edit_admin_page_url(f.object.page.id), :class=>:button
      end
  end
  
end
  