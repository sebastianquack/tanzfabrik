desc 'seed text items'
task :seed_text_items => :environment do

  def seed_item(name, content_de, content_en)
    item = TextItem.find_by(name: name)
    if !item
      TextItem.create(
        name: name,
        content_de: content_de,
        content_en: content_en
      )
      puts "seeded text item " + name
    else
      puts "text item " + name + " already defined, updating"
      item.content_de = content_de
      item.content_en = content_en
      item.save
    end
  end

  seed_item("page_title", "Tanzfabrik Berlin", "Tanzfabrik Berlin")
end

