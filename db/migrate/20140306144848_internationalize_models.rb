class InternationalizeModels < ActiveRecord::Migration
  def change
    rename_column :event_types, :name, :name_de
    add_column :event_types, :name_en, :string

    rename_column :events, :title, :title_de
    add_column :events, :title_en, :string
    
    rename_column :events, :description, :description_de
    add_column :events, :description_en, :text
    
    rename_column :events, :warning, :warning_de
    add_column :events, :warning_en, :string

    rename_column :events, :language, :language_de
    add_column :events, :language_en, :string

    rename_column :festivals, :name, :name_de
    add_column :festivals, :name_en, :string
    
    rename_column :festivals, :description, :description_de
    add_column :festivals, :description_en, :text
    
    rename_column :locations, :description, :description_de
    add_column :locations, :description_en, :text

    rename_column :pages, :title, :title_de
    add_column :pages, :title_en, :string

    rename_column :pages, :content, :content_de
    add_column :pages, :content_en, :text

    rename_column :people, :bio, :bio_de
    add_column :people, :bio_en, :text
    
    rename_column :repeat_modes, :description, :description_de
    add_column :repeat_modes, :description_en, :text
    
    rename_column :studios, :description, :description_de
    add_column :studios, :description_en, :text
    
    rename_column :tags, :name, :name_de
    add_column :tags, :name_ed, :string
  end
end

