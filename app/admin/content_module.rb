ActiveAdmin.register ContentModule do

  menu false

  #  t.string "module_type"
  #  t.integer "page_id"
  #  t.string "style_option"
  #  t.string "super"
  #  t.string "headline"
  #  t.string "sub"
  #  t.text "main_text"
  #  t.text "main_text_col2"
  #  t.text "special_text"


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :module_type, :style_option, :draft, :headline_de, :headline_en, :super_de, :super_en, :sub_de, :sub_en, :special_text_de, :special_text_en, :rich_content_1_de, :rich_content_1_en, :rich_content_2_de, :rich_content_2_en, :custom_html_de, :custom_html_en, :parameter


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
        content_module.page.title_de
      end
      row :module_type do |content_module|
        t("content_modules.module_types." + content_module.module_type)
      end
      row :style_option do |content_module|
        t("content_modules.style_options." + content_module.style_option)
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
        render partial: "/content_modules/index", locals: {content_module: content_module}
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

      def make_input(f, mtype, field, active, action_text)    
        
        unless action_text
          # special types
          if field == "parameter" && (mtype == "festival_programm" || mtype == "festival_vorschau")
            f.input field, :as => :select, :collection => Festival.all, :include_blank => false
          else
            return f.input field, :wrapper_html => { 
              :class => active ? "cm-field-active" : "cm-field-hidden" 
            }
          end
        else 
          return f.input field, :wrapper_html => { 
            :class => active ? "cm-field-active" : "cm-field-hidden" 
          }, :as => :action_text
        end        
      end 

      def content_module_input(f, mtype, field, action_text=false, localise=true)
        active = CM_CONFIG[mtype]["form-fields"] ? CM_CONFIG[mtype]["form-fields"].include?(field) : false
        if localise
          return [
            make_input(f, mtype, field + "_de", active, action_text),
            make_input(f, mtype, field + "_en", active, action_text)
          ]
        else
          return make_input(f, mtype, field, active, action_text)
        end
      end

      f.inputs "Meta" do
        f.input :module_type, :as => :select, :collection => CM_CONFIG.keys.map{|k| [t("content_modules.module_types." + k), k]}, :include_blank => false, selected: f.object.module_type || default_module_type
        if style_options.length > 0
          f.input :style_option, :as => :select, :collection => style_options, :include_blank => false
        end
        f.input :draft, :label => t(:draft)
        f.li link_to "Modul löschen", delete_content_module_admin_content_module_path, :class => "button active-admin-delete-content-module"
      end
      f.inputs "Content" do
        content_module_input f, type, "super"
        content_module_input f, type, "headline"
        content_module_input f, type, "sub"
        content_module_input f, type, "special_text"
        content_module_input f, type, "parameter", false, false
        content_module_input f, type, "rich_content_1", true
        content_module_input f, type, "rich_content_2", true
        content_module_input f, type, "custom_html"
      end

      if !CM_CONFIG[type].has_key? "images" || CM_CONFIG[type]["images"] != false
        f.inputs "Images", :id => "active_admin_cm_images" do
          f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
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
  