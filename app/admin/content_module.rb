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
  permit_params :module_type, :style_option, :draft, :headline, :super, :sub, :special_text, :rich_content_1, :rich_content_2


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
      row :page_id
      row :module_type
      row :style_option
      row :draft
      row "Vorschau" do |content_module|
        render partial: "/content_modules/index", locals: {content_module: content_module}
      end
      row "Links" do |content_module|
        ul do
          li link_to "Seite bearbeiten", edit_admin_page_url(content_module.page.id)
          li link_to "Seite anschauen", content_module.page
        end
      end
    end
  end

  
  form do |f|

      #para CM_CONFIG[f.object.module_type].inspect

      def content_module_input(f, field, action_text=false)
        Rails.logger.info field
        Rails.logger.info CM_CONFIG[f.object.module_type]["form-fields"].include?(field)
        unless action_text
          return f.input field, :wrapper_html => { 
            :class => CM_CONFIG[f.object.module_type]["form-fields"].include?(field) ? "cm-field-active" : "cm-field-hidden" 
          }
        else 
          return f.input field, :wrapper_html => { 
            :class => CM_CONFIG[f.object.module_type]["form-fields"].include?(field) ? "cm-field-active" : "cm-field-hidden" 
          }, :as => :action_text
        end
      end

      style_options = CM_CONFIG[f.object.module_type]["style-options"].map { |a| [ a, a ] }
      
      f.inputs "Meta" do
        f.input :module_type, :as => :select, :collection => CM_CONFIG.keys, :include_blank => false
        f.input :style_option, :as => :select, :collection => style_options, :include_blank => false
        f.input :draft
      end
      f.inputs "Content" do
        content_module_input f, "super"
        content_module_input f, "headline"
        content_module_input f, "sub"
        content_module_input f, "special_text"
        content_module_input f, "rich_content_1", :action_text
        content_module_input f, "rich_content_2", :action_text
      end

      f.inputs "Images" do
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

      f.inputs "Downloads" do
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
      
      f.actions do
        f.action :submit
        f.action :cancel # no idea why, but this leads back to page edit view which is good
      end
  end
  
end
  