ActiveAdmin.register FestivalContainer do

  menu false

  permit_params :name_de, :description_de, :name_en, :description_en, :display,
    :images_attributes => [:id, :description_de, :description_en, :license, :attachment, :_destroy],
    :downloads_attributes => [:id, :description_de, :description_en, :attachment_de, :attachment_en, :_destroy]
      
  index do
    selectable_column
    column :name_de
    column :description do |festival_container|
      festival_container.description_de.html_safe
    end
    column :images do |festival_container|
      festival_container.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
    end
    column :display
    actions
  end
  
  filter :name_de
  filter :description_de
  filter :display
   
  config.per_page = 100
    
  show do
    attributes_table do
      row :name_de
      row :name_en
      row :description_de do |festival_container|
        festival_container.description_de.html_safe if festival_container.description_de
      end
      row :description_en do |festival_container|
        festival_container.description_en.html_safe if festival_container.description_en
      end
      row :display
      row "Festivals" do |festival_container|
        festival_container.festivals.map { |f| (link_to f.name, admin_festival_path(f)) }.join(', ').html_safe
      end      
      row "images" do |festival_container|
        festival_container.images.map { |i| image_tag i.attachment(:thumb) }.join('').html_safe
      end
      
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name_de
      f.input :name_en
      f.input :description_de, :input_html => { :class => 'wysihtml5' }
      f.input :description_en, :input_html => { :class => 'wysihtml5' }
    end

    f.inputs "Images" do
      f.has_many :images, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        #f_f.inputs do
          f_f.input :description_de
          f_f.input :description_en
          f_f.input :license
          if f_f.object.attachment.exists?
            f_f.input :attachment, :as => :file, :required => false, :hint => f_f.template.image_tag(f_f.object.attachment.url(:thumb))
          else
            f_f.input :attachment, :as => :file, :required => false
          end
        #end
      end
    end

    f.inputs "Downloads" do
      f.has_many :downloads, heading: false, :new_record => true, :allow_destroy => true do |f_f|
        #f_f.inputs do
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
        #end
      end
    end    
    
    f.inputs "Special" do
      f.input :display
    end
    
    f.actions
  end
    
end
