desc 'sets up content modules for page data from old site'
task :populate_content_modules => :environment do

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
        "festivals", # no page?
        "kindertanz", 
        "kuenstler",
        "kursplan",
        "lehrer",
        "newsletter", # no page?
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

end

