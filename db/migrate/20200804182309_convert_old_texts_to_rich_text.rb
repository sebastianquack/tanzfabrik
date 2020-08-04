class ConvertOldTextsToRichText < ActiveRecord::Migration[6.0]
  def up
    puts "converting content to action text"

    Event.all.each do |event|

      if event.rich_content_de.empty? 
        event.rich_content_de = event.description_de 
        puts "DONE    event #{event.id.to_s} de"
      else 
        puts "SKIPPED event #{event.id.to_s} de"
      end

      if event.rich_content_en.empty? 
        event.rich_content_en = event.description_en
        puts "DONE    event #{event.id.to_s} en"
      else 
        puts "SKIPPED event #{event.id.to_s} en"
      end

      event.save
    end
  
    Festival.all.each do |festival|

      if festival.rich_content_de.empty? 
        festival.rich_content_de = festival.description_de 
        puts "DONE    festival #{festival.id.to_s} de"
      else 
        puts "SKIPPED festival #{festival.id.to_s} de"
      end

      if festival.rich_content_en.empty? 
        festival.rich_content_en = festival.description_en
        puts "DONE    festival #{festival.id.to_s} en"
      else 
        puts "SKIPPED festival #{festival.id.to_s} en"
      end

      festival.save
    end
  
    Person.all.each do |person|

      if person.rich_content_de.empty? 
        person.rich_content_de = person.bio_de 
        puts "DONE    person #{person.id.to_s} de"
      else 
        puts "SKIPPED person #{person.id.to_s} de"
      end

      if person.rich_content_en.empty? 
        person.rich_content_en = person.bio_en
        puts "DONE    person #{person.id.to_s} en"
      else 
        puts "SKIPPED person #{person.id.to_s} en"
      end

      person.save
    end
  
    Studio.all.each do |studio|

      if studio.rich_content_de.empty? 
        studio.rich_content_de = studio.description_de 
        puts "DONE    studio #{studio.id.to_s} de"
      else 
        puts "SKIPPED studio #{studio.id.to_s} de"
      end

      if studio.rich_content_en.empty? 
        studio.rich_content_en = studio.description_en
        puts "DONE    studio #{studio.id.to_s} en"
      else 
        puts "SKIPPED studio #{studio.id.to_s} en"
      end

      studio.save
    end
  end
end
