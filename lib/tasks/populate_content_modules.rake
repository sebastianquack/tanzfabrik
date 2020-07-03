desc 'sets up content modules for page data from old site'
task :populate_content_modules => :environment do

  # go over imported pages
  Page.all.each do |page|  
    
    # do this for all pages that use the old content attribute
    if page.content_de
      puts "re-creating content modules for page " + page.title_de

      ContentModule.where(page_id: page.id).delete_all

      cm = ContentModule.create({
          page_id: page.id,
          module_type: :default,
          headline: page.title_de,
          main_text: page.content_de,
          order: 0
        });

      page.images.each do |image|
        image.content_module_id = cm.id
        image.save
      end

      page.downloads.each do |download|
        download.content_module_id = cm.id
        download.save
      end

      # set up a menu item for the page if there isn't one already
      menu_items = MenuItem.where(page_id: page.id)
      if menu_items.length == 0
        MenuItem.create(
          page_id: page.id,
          key: page.slug,
          name_de: page.title_de,
          name_en: page.title_en
        )
      end

      # some pages need special modules to work, todo: expand list
      specials = [
        "dance_intensive_lehrer",
        "festivals", # no page, just template?
        "kuenstler",
        "kursplan",
        "lehrer",
        "newsletter", # no page, just template?
        "performance_projekte",
        "profitraining",
        "programm",
        "studios",
        "workshop_anmeldung",
        "workshop_programm"
      ]

      if specials.include? page.slug
        ContentModule.create({
          page_id: page.id,
          module_type: page.slug,
          order: 1
        });
      end

    end

  end
  
  # seed data for menu items
  basic_menu_data = [
    {
      parent_key: nil,
      key: "buehne",
      name_de: "Bühne",
      name_en: "Stage",
      page_slug: "buehne-landing"
    },
    {
      parent_key: "buehne",
      key: "programm",
      name_de: "Programm",
      name_en: "Programme",
      page_slug: "buehne-programme"
    },
    {
      parent_key: "programm",
      key: "bla",
      name_de: "bla",
      name_en: "bla",
      page_slug: nil
    },
  ]

  basic_menu_data.each do |item|

    puts item.to_s

    # load parent item if specified
    parent_item = nil
    if item[:parent_key]
      parent_item = MenuItem.find_by key: item[:parent_key]
      if item[:parent_key] && !parent_item
        puts "parent menu item not found: " + item[:parent_key]
      end
    end

    puts parent_item

    # load page if specified
    page = nil
    if item[:page_slug]
      page = Page.find_by slug: item[:page_slug]
      if item[:page_slug] && !page
        puts "no page found for slug: " + item[:page_slug]
      end
    end

    puts page

    # check if this menu_item exist already
    menu_item = MenuItem.find_by key: item[:key]

    puts menu_item

    if menu_item
      # update it
      menu_item.parent_id = parent_item.id if parent_item
      menu_item.page_id = page.id if page
      menu_item.name_de = item[:name_de]
      menu_item.name_en = item[:name_en]
      menu_item.save
    else 
      # create it
      MenuItem.create(
        parent_id: parent_item ? parent_item.id : nil,
        key: item[:key],
        page_id: page ? page.id : nil,
        name_de: item[:name_de],
        name_en: item[:name_en]
      )
    end
  
  end

end

