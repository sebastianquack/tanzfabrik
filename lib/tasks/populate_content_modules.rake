desc 'sets up content modules for page data from old site'
task :populate_content_modules => :environment do

  # clean slate for menu structure
  MenuItem.delete_all

  # clean slate for content modules
  ContentModule.delete_all

  # some pages need special modules to work, todo: expand list
  specials = [
    "dance_intensive_lehrer",
    "festivals", 
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

  def add_special_module_to_page page, module_type, order 

    # special populations
    if module_type == "kursplan"
      ContentModule.create({
        page_id: page.id,
        module_type: page.slug,
        parameter: "Kreuzberg",
        order: order
      });
      ContentModule.create({
        page_id: page.id,
        module_type: page.slug,
        parameter: "Wedding",
        order: order + 1
      });
      ContentModule.create({
        page_id: page.id,
        module_type: page.slug,
        parameter: "Online",
        order: order + 2
      });
    elsif module_type == "festivals"
      ContentModule.create({
        page_id: page.id,
        module_type: "festival_archiv",
        order: order
      });
    elsif module_type == "kuenstler"
      ContentModule.create({
        page_id: page.id,
        module_type: "people_gallery",
        parameter: "Künstler",
        order: order
      });
    elsif module_type == "lehrer"
      ContentModule.create({
        page_id: page.id,
        module_type: "people_gallery",
        parameter: "Kurslehrer",
        order: order
      });
    elsif module_type == "dance_intensive_lehrer"
      ContentModule.create({
        page_id: page.id,
        module_type: "people_gallery",
        parameter: "Dance-Intensive",
        order: order
      });
    # default
    else
      ContentModule.create({
        page_id: page.id,
        module_type: page.slug,
        order: 1
      });
    end

  end
      
  unregistered_menu_item = MenuItem.create(
          key: "unregistered",
          name_de: "Ohne Ort im Menü",
          name_en: "Unregistered Elements",
          position: 100
        )
  puts "created special item for unregistered items, id " + unregistered_menu_item.to_s
  
  # go over imported pages
  Page.all.each do |page|  
    
    # do this for all pages that use the old content attribute
    if page.content_de
      puts "re-creating content modules for page " + page.title_de
      ContentModule.where(page_id: page.id).delete_all
      cm = ContentModule.create({
          page_id: page.id,
          module_type: :default,
          headline_de: page.title_de,
          headline_en: page.title_en,
          rich_content_1_de: page.content_de,
          rich_content_1_en: page.content_en,
          order: 0
        });
      page.images.each do |image|
        puts "moving image " + image.id.to_s + " to cm " + cm.id.to_s
        image.content_module_id = cm.id
        if image.save
          puts "success"
        else
          puts "error"
          puts image.errors.full_messages
        end
      end
      page.downloads.each do |download|
        puts "moving download to cm"
        download.content_module_id = cm.id
        download.save
      end
      # set up a menu item for the page if there isn't one already
      menu_items = MenuItem.where(page_id: page.id)
      if menu_items.length == 0
        MenuItem.create(
          parent_id: unregistered_menu_item.id,
          page_id: page.id,
          key: page.slug,
          name_de: page.title_de,
          name_en: page.title_en
        )
      end
      
      if specials.include? page.slug
        add_special_module_to_page page, page.slug, 1
      end
    end
  end
  
  # seed data for menu items
  basic_menu_data = [
    # root
    {
      key: "start",
      parent_key: nil,
      name_de: "Home",
      name_en: "Home",
      page_slug: nil
    },
    # main three branches: buehne, schule, fabrik
    {
      key: "buehne",
      parent_key: "start",
      name_de: "Bühne",
      name_en: "Stage",
      page_slug: "buehne"
    },
    {
      key: "schule",
      parent_key: "start",
      name_de: "Schule",
      name_en: "Schule",
      page_slug: "schule"
    },
    {
      key: "fabrik",
      parent_key: "start",
      name_de: "Fabrik",
      name_en: "Factory",
      page_slug: "fabrik"
    },
    # buehne/programm
    {
      key: "buehne-programm",
      parent_key: "buehne",
      name_de: "Programm",
      name_en: "Programme",
      page_slug: "programm" # default for section
    },
    {
      key: "calendar",
      parent_key: "buehne-programm",
      name_de: "Kalender",
      name_en: "Kalendar",
      page_slug: "programm"
    },
    {
      key: "programm",
      parent_key: "buehne-programm",
      name_de: "Festivals & Projekte",
      name_en: "Fetivals & Projects",
      page_slug: "festivals"
    },
    # buehne/produktionshaus
    {
      key: "buehne-produktionshaus",
      parent_key: "buehne",
      name_de: "Produktionhaus",
      name_en: "Production House",
      page_slug: "kuenstler" # default for section
    },
    {
      key: "kuenstler",
      parent_key: "buehne-produktionshaus",
      name_de: "Künstler*innen",
      name_en: "Artists",
      page_slug: "kuenstler"
    },
    {
      key: "residenzen",
      page_slug: "residenzen",
      parent_key: "buehne-produktionshaus",
      name_de: "Residenzen",
      name_en: "Residencies",
    },
    {
      key: "networks",
      parent_key: "buehne-produktionshaus",
      name_de: "Netzwerke",
      name_en: "Networks",
      page_slug: "networks"
    },
    # buehne/besuch
    {
      key: "buehne-besuch",
      parent_key: "buehne",
      name_de: "Besuch",
      name_en: "Visit",
      page_slug: "tickets" # default for section
    },
    {
      key: "tickets",
      parent_key: "buehne-besuch",
      name_de: "Tickets",
      name_en: "Tickets",
      page_slug: "tickets"
    },
    {
      key: "spielorte",
      parent_key: "buehne-besuch",
      name_de: "Spielorte",
      name_en: "Venues",
      page_slug: nil
    },
    {
      key: "kontakt",
      parent_key: "buehne-besuch",
      name_de: "Kontakt",
      name_en: "Contact",
      page_slug: "kontakt"
    },
    # schule/tanzklassen
    {
      key: "schule-tanzklassen",
      parent_key: "schule",
      name_de: "Tanzklassen",
      name_en: "Classes",
      page_slug: "kursplan" # default for section
    },
    {
      key: "kursplan",
      parent_key: "schule-tanzklassen",
      name_de: "Kursplan",
      name_en: "Class Schedule",
      page_slug: "kursplan"
    },
    {
      key: "performance_projekte",
      page_slug: "performance_projekte",
      parent_key: "schule-tanzklassen",
      name_de: "Performance Projekte",
      name_en: "Performance Projects",
    },
    {
      key: "profitraining",
      page_slug: "profitraining",
      parent_key: "schule-tanzklassen",
      name_de: "Profiklassen",
      name_en: "Professional Classes",
    },
    {
      key: "lehrer",
      page_slug: "lehrer",
      parent_key: "schule-tanzklassen",
      name_de: "Lehrer*innen",
      name_en: "Teachers",
    },
    {
      key: "preise-der-tanzklassen",
      page_slug: "preise-der-tanzklassen",
      parent_key: "schule-tanzklassen",
      name_de: "Preise",
      name_en: "Prices",
    },
    {
      key: "tanzklassen-weiteres",
      page_slug: "tanzklassen-weiteres",
      parent_key: "schule-tanzklassen",
      name_de: "Weiteres",
      name_en: "More",
    },
    # schule/workshops
    {
      key: "schule-workshops",
      page_slug: "workshop_programm", # default for section
      parent_key: "schule",
      name_de: "Workshops",
      name_en: "Workshops",
    },
    {
      key: "workshop_programm",
      page_slug: "workshop_programm",
      parent_key: "schule-workshops",
      name_de: "Kalender",
      name_en: "Kalendar",
    },
    {
      key: "workshop_anmeldung",
      page_slug: "workshop_anmeldung",
      parent_key: "schule-workshops",
      name_de: "Anmeldung",
      name_en: "Registration",
    },
    # schule/dance_intensive
    {
      key: "schule-dance-intensive",
      page_slug: "dance_intensive", # default for section
      parent_key: "schule",
      name_de: "Dance Intensive",
      name_en: "Dance Intensive",
    },
    {
      key: "dance_intensive_programm",
      page_slug: "dance_intensive",
      anchor: "programm",
      old_page: "dance_intensive_programm",
      parent_key: "schule-dance-intensive",
      name_de: "Programm",
      name_en: "Programm"
    },
    {
      key: "dance_intensive_lehrer",
      page_slug: "dance_intensive",
      anchor: "teachers",
      old_page: "dance_intensive_lehrer",
      parent_key: "schule-dance-intensive",
      name_de: "Lehrer*innen",
      name_en: "Teachers"
    },
    {
      key: "dance_intensive_bewerbung",
      page_slug: "dance_intensive",
      anchor: "bewerbung",
      old_page: "dance_intensive_bewerbung",
      parent_key: "schule-dance-intensive",
      name_de: "Bewerbung",
      name_en: "Application"
    },
    # schule/veranstaltungen
    {
      key: "schule-veranstaltungen",
      page_slug: nil,
      parent_key: "schule",
      name_de: "Veranstaltungen",
      name_en: "Events",
    },
    {
      key: "schule-veranstaltungen-overview",
      page_slug: "schule-veranstaltungen-overview",
      parent_key: "schule-veranstaltungen",
      name_de: "Übersicht",
      name_en: "Overview",
    },
    # fabrik/ueber-uns
    {
      key: "fabrik-ueber-uns",
      page_slug: "profil_partner", # default
      parent_key: "fabrik",
      name_de: "Über uns",
      name_en: "About us",
    },
    {
      key: "fabrik-geschichte",
      page_slug: "fabrik-geschichte",
      parent_key: "fabrik-ueber-uns",
      name_de: "Geschichte",
      name_en: "History",
    },
    {
      key: "profil_partner",
      page_slug: "profil_partner",
      parent_key: "fabrik-ueber-uns",
      name_de: "Profil & Partner",
      name_en: "Profile & Partners",
    },
    {
      key: "team",
      page_slug: "team",
      parent_key: "fabrik-ueber-uns",
      name_de: "Team",
      name_en: "Team",
    },
    {
      key: "fabrik-standorte",
      page_slug: "fabrik-standorte",
      parent_key: "fabrik-ueber-uns",
      name_de: "Standorte",
      name_en: "Locations",
    },
    # fabrik/studios
    {
      key: "fabrik-studios",
      page_slug: "studios",
      parent_key: "fabrik",
      name_de: "Studios",
      name_en: "Studios",
    },
    {
      key: "studios",
      page_slug: "studios",
      parent_key: "fabrik-studios",
      name_de: "Übersicht",
      name_en: "Overview",
    },
    {
      key: "vermietungsinfo",
      page_slug: "vermietungsinfo",
      parent_key: "fabrik-studios",
      name_de: "Vergabe",
      name_en: "Renting",
    },
    # fabrik/contact
    {
      key: "fabrik-kontakt",
      page_slug: "kontakt",
      parent_key: "fabrik",
      name_de: "Kontakt",
      name_en: "Contact",
    },    
  ]
  submenu_counter = 0
  basic_menu_data.each_with_index do |item, index|
    puts item.to_s
    # load parent item if specified
    parent_item = nil
    if item[:parent_key]
      parent_item = MenuItem.find_by key: item[:parent_key]
      if item[:parent_key] && !parent_item
        puts "parent menu item not found: " + item[:parent_key]
      end
    end
    # load page if specified, create if slug is defind but page not found
    page = nil
    if item[:page_slug]
      page = Page.find_by slug: item[:page_slug]
      if item[:page_slug] && !page
        puts "no page found for slug: " + item[:page_slug]
        puts "creating..."
        page = Page.create(
          slug: item[:page_slug]
        )
      end
    end
    # check if this menu_item exist already
    menu_item = MenuItem.find_by key: item[:key]
    if menu_item
      # update it
      menu_item.parent_id = parent_item ? parent_item.id : nil
      menu_item.page_id = page.id if page
      menu_item.anchor = item[:anchor] if item[:anchor]
      menu_item.name_de = item[:name_de]
      menu_item.name_en = item[:name_en]
      menu_item.position = index
      menu_item.save
      puts "updated menu_item " + item[:key]
    else 
      # create it
      MenuItem.create(
        parent_id: parent_item ? parent_item.id : nil,
        key: item[:key],
        page_id: page ? page.id : nil,
        anchor: item[:anchor] ? item[:anchor] : nil, 
        name_de: item[:name_de],
        name_en: item[:name_en],
        position: index
      )
      puts "created menu_item " + item[:key]
    end

    # if this entry has an anchor specified, add a cm to the page
    if item[:anchor] && page
      puts "creating divider " + item[:anchor] + " on page " + page.slug
      ContentModule.create({
          page_id: page.id,
          module_type: :submenu_divider,
          parameter: item[:anchor],
          headline_de: item[:name_de],
          headline_en: item[:name_en],
          order: submenu_counter
      })      
      submenu_counter += 1
      
      puts "looking for old page " + item[:old_page]
      old_page = Page.find_by slug: item[:old_page]

      if old_page
        puts "merging old page as default content module"
        ContentModule.create({
            page_id: page.id,
            module_type: :default,
            headline_de: item[:name_de],
            headline_en: item[:name_en],
            rich_content_1_de: old_page.content_de,
            rich_content_1_en: old_page.content_en,
            order: submenu_counter
        })
        submenu_counter += 1        
        if specials.include? old_page.slug
          puts "adding special content module for " + old_page.slug
          add_special_module_to_page page, old_page.slug, submenu_counter
          submenu_counter += 1
        end
      else
        puts "creating blank content module for subsection"
        ContentModule.create({
            page_id: page.id,
            module_type: :default,
            headline_de: item[:name_de],
            headline_en: item[:name_en],
            order: submenu_counter
        })      
        submenu_counter += 1
      end
    else
      submenu_counter = 0
    end
  
  end


  # add tags to people

  Person.all.each do |person|  

    tags = []

    if person.dance_intensive 
      tags.push "Dance-Intensive"
    end

    if person.kurslehrer?
      tags.push "Kurslehrer"
    end

    if person.artist?
      tags.push "Künstler"
    end

    person.tags = tags.join(" ")
    person.save

  end

  # create a page for each festival

  Festival.all.each do |festival|

    # check if festival does not yet have a page
    if !festival.page
      # create brand new page - do this only once to not regenerate pages each time

      slug = festival.name_de.parameterize

      # check if slug exists
      if Page.find_by(:slug => slug)
        slug = "festival-" + festival.id.to_s 
      end  

      p = Page.create(
        slug: slug
      )

      if p.errors
        puts p.errors.full_messages
      end

      # link it to the festival 
      festival.page_id = p.id
      festival.save

      puts "created new page " + p.slug + " for festival " + festival.name_de
    end

    if festival.page_id 

      # first module contains all static content
      cm = ContentModule.create({
          page_id: festival.page_id,
          module_type: "festival_vorschau",
          parameter: festival.id,
          order: 1
      })
      
      # second is for the dynamic programm
      ContentModule.create({
          page_id: festival.page_id,
          module_type: "festival_programm",
          parameter: festival.id,
          order: 2
      })            

    end

  end

end

