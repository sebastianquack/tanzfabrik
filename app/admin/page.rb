ActiveAdmin.register Page do

  menu :priority => 0
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :title_de, :content_de, :title_en, :content_en, 
    :images_attributes => [:id, :description, :license, :attachment, :_destroy],
    :downloads_attributes => [:id, :description_de, :description_en, :attachment, :_destroy]

  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  index do
    selectable_column
    column "URL" do |page|
      link_to page.slug, page_path(page)
    end
    column :title
    column :content
    column Image.model_name.human do |page|
      page.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    
    default_actions
  end

  filter :title_de
  filter :content_de
  
  config.per_page = 100
  
  show do
    attributes_table do
      row "URL" do |page|
        link_to page.slug, page
      end
      row :title_de
      row :title_en
      row :content_de do |page|
        page.content_de.html_safe if page.content_de
      end
      row :content_en do |page|
        page.content_en.html_safe if page.content_en
      end
      row Image.model_name.human do |page|
        page.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      end
      row Download.model_name.human do |page|
        page.downloads.map { |d| link_to(d.description, d.attachment.url) }.join('').html_safe
      end
      
    end
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :title_de
      f.input :title_en
    end
    f.inputs "Content" do
      f.input :content_de, :input_html => { :class => 'wysihtml5' }
      f.input :content_en, :input_html => { :class => 'wysihtml5' }
    end
    f.inputs "Images" do
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
    f.inputs "Downloads" do
      f.has_many :downloads, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        f_f.inputs do
          f_f.input :description_de
          f_f.input :description_en
          if f_f.object.attachment.exists?
            f_f.input :attachment, :as => :file, :required => false, :hint => link_to(f_f.object.attachment.original_filename, f_f.object.attachment.url)
          else
            f_f.input :attachment, :as => :file, :required => false
          end
        end
      end
    end
    
    
    f.actions
  end
  
end
