ActiveAdmin.register TextItem do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :content_de, :content_en, :rich_content_de, :rich_content_en,
    :images_attributes => [:id, :description, :license, :attachment, :link_href_de, :link_href_en, :_destroy]
  
  index do 
    selectable_column
      column :name
      column :content_de
      column :content_en
      column :rich_content_de do |text_item| 
        div text_item.rich_content_de
      end
      column :rich_content_en do |text_item| 
        div text_item.rich_content_en
      end
    actions
  end
  
  config.filters = false
  
  show do
    attributes_table do
      row :name
      row :content_de
      row :content_en
      row :rich_content_de
      row :rich_content_en
    end
  end
  
  form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :content_de
        f.input :content_en

        f.input :rich_content_de, :as => :action_text
        f.input :rich_content_en, :as => :action_text

        f.inputs Image.model_name.human do
          f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
            f_f.input :description
            f_f.input :license
            f_f.input :link_href_de
            f_f.input :link_href_en
            if f_f.object.attachment.exists?
              f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
            else
              f_f.input :attachment, :as => :file, :required => false
            end
          end
        end
      end
      f.actions
  end
  
end
  