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
  permit_params :module_type, :style_option, :headline # todo add all

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
      row "page" do |content_module|
        link_to "go to page", edit_admin_page_url(content_module.page.id)
      end
    end
  end
  
  form do |f|
      f.inputs "Meta" do
        f.input :module_type
        f.input :style_option
      end
      f.inputs "Content" do
        f.input :super
        f.input :headline
        f.input :sub
        f.input :main_text
        f.input :main_text_col2
        f.input :special_text
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
  