desc 'seed text items'
task :seed_text_items => :environment do

  def seed_item(name, content_de="", content_en="", rich_content_de="", rich_content_en="" )
    item = TextItem.find_by(name: name)
    if !item
      TextItem.create(
        name: name,
        content_de: content_de,
        content_en: content_en,
        rich_content_de: rich_content_de,
        rich_content_en: rich_content_en,
      )
      puts "seeded text item " + name
    else
      puts "text item " + name + " already defined, NOT updating"
      # item.content_de = content_de
      # item.content_en = content_en
      # item.rich_content_de = rich_content_de
      # item.rich_content_en = rich_content_en
      # item.save
    end
  end

  seed_item("page_title", "Tanzfabrik Berlin", "Tanzfabrik Berlin")

  ['schule', 'buehne', 'fabrik'].each do |section|
    seed_item("footer_" + section + "_content_left", nil, nil, "<p>#{section} links</p>", "<p>#{section} right</p>")
    seed_item("footer_" + section + "_content_right", nil, nil, "<p>#{section} rechts</p>", "<p>#{section} left</p>")
    seed_item("footer_" + section + "_instagram_link", "http://", "http://")
    seed_item("footer_" + section + "_vimeo_link", "http://", "http://")
    seed_item("footer_" + section + "_facebook_link", "http://", "http://")
  end

end

