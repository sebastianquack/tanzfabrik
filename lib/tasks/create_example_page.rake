desc 'create example page containing all modules'
task :create_example_page => :environment do

  begin
    existing_page = Page.find("module")
    existing_page.delete
  rescue ActiveRecord::RecordNotFound
    # no problem
  end

  $p = Page.create(
    title_de: "Module",
    title_en: "Modules",
  )

  p=$p

  if p.errors
    puts p.errors.full_messages
  end

  $module_id_prefix = 100000000
  $counter = 1

  img_landscape = {
    description: "description description description",
    license: "licence licence licence",
    attachment: File.open(Rails.public_path.join('seeds', 'landscape.png')),
  }

  img_portrait = {
    description: "description description description",
    license: "licence licence licence",
    attachment: File.open(Rails.public_path.join('seeds', 'portrait.png'))
  }

  img_square = {
    description: "description description description",
    license: "licence licence licence",
    attachment: File.open(Rails.public_path.join('seeds', 'square.png'))
  }  

  pdf = {
    description_de: "Beispiel PDF",
    description_en: "Example PDF",
    attachment_de: File.open(Rails.public_path.join('seeds', 'testPDF')),
    attachment_en: File.open(Rails.public_path.join('seeds', 'testPDF'))
  }

  def make_module(attributes_hash, images=nil, download=nil)
    puts "creating " + ($module_id_prefix + $counter).to_s + " " + attributes_hash[:module_type].to_s + " / " + attributes_hash[:headline_de].to_s

    begin
      #ContentModule.find($module_id_prefix + $counter).slides.destroy_all
      ContentModule.find($module_id_prefix + $counter).downloads.destroy_all
      ContentModule.find($module_id_prefix + $counter).images.destroy_all
      ContentModule.destroy $module_id_prefix + $counter
    rescue ActiveRecord::RecordNotFound
      # no problem
    end
  
    cm = ContentModule.create({
        id: $module_id_prefix + $counter,
        page_id: $p.id,
        module_type: "content_element",
        section: "buehne",
        headline_de: "",
        headline_en: "",
        rich_content_1_de: "",
        rich_content_1_en: "",
        special_text_de: "",
        special_text_en: "",
        link_href_de:"",
        link_href_en:"",
        link_title_de:"",
        link_title_en:"",
        order: $counter += 1
    }.merge(attributes_hash))

    if images
      images = [images] if not images.is_a? Array
      [images].each do |image|
        cm.images.create(image)
      end
    end

    if download
      cm.downloads.create(download)
    end

    cm.save!

  end

  # BEGIN


### feature / The Morning Show of Celine and Renana - Focus: Choreographers

rich_content_1 = <<~RICHCONTENT1
<b>TV-Show</b> mit Igor Dobricic, Guillaume Marie, Roger Sala Reyner
RICHCONTENT1

make_module({
  module_type: "feature",
  section: "buehne",
  headline_de: "The Morning Show of Celine and Renana - Focus: Choreographers",
  headline_en: "The Morning Show of Celine and Renana - Focus: Choreographers",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
  special_text_de: "02.02.2020, Kreuzberg 1",
  special_text_en: "02.02.2020, Kreuzberg 1",
}, img_landscape)


### page_intro / Workshops

rich_content_1 = <<~RICHCONTENT1
Die Übersicht über Workshops sind im dazugehörigen PDF zu finden
RICHCONTENT1

make_module({
  module_type: "page_intro",
  section: "schule",
  headline_de: "Work\\shops",
  headline_en: "Work\\shops",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
}, img_landscape)

### page_intro / Profiklassen

rich_content_1 = <<~RICHCONTENT1
1 Klasse á 90 Minuten: 7 € / 10er Karte: 65 €<br />
1 Klasse á 120 Minuten: 8,50 € / 10er Karte: 65 € +1 € pro 120 Min.-Klasse.
RICHCONTENT1

rich_content_2 = <<~RICHCONTENT2
Zur Vermeidung von Verletzungen bitte beachten: High Level insbesondere bei den Trainings von Stella Zannou und Blenard Azizaj.<br />
<br />
Kein Training während der Workshops, an gesetzlichen Feiertagen und in den Ferien der Tanzfabrik. Um an anderen Tanzklassen der Tanzfabrik teilzunehmen, können Tanzprofis auf Anfrage eine 10er Karte zu 65 € (10 x 75 Min.), zu 80 € (10 x 90 Min.), 95 € (10 x 120 Min.) erwerben.
RICHCONTENT2

make_module({
  module_type: "page_intro",
  section: "schule",
  headline_de: "Profi\\klassen",
  headline_en: "Profi\\klassen",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
  rich_content_2_de: rich_content_2,
  rich_content_2_en: "",      
}, img_landscape, pdf)

### page_intro / Dance Intensive

special_text = <<~SPECIALTEXT
31.8.2020 – 2.7.2021
10 Monate 20 Klassen pro Woche
Individuelle Betreuung
340 € pro Monat
SPECIALTEXT

rich_content_1 = <<~RICHCONTENT1
Die Tanzfabrik Berlin bietet für alle, die sich intensiv mit Tanz beschäftigen möchten, ein zehnmonatiges Dance Intensive- Programm an. Dance Intensive ist ein Qualifizierungsprogramm, das sich an Personen richtet, die sich im Bereich Tanz orientieren, weiterbilden und/oder sich auf Aufnahmeprüfungen an unterschiedlichen nationalen und internationalen Ausbildungsinstituten vorbereiten möchten. Das Programm bietet die Möglichkeit der Orientierung im Bereich Zeitgenössischer Tanz und bietet Einblick in Tanzrichtungen und Tanzstile um sich gezielt auf eine zukünftige Ausbildung vorzubereiten (das Vortanzen an Hochschulen und Instituten) oder die Integration des erlernten Wissens in bestehende Berufsbereiche. Ziel des Qualifizierungsprogramms ist es, ein Fundament in tänzerischen Disziplinen und Techniken zu legen sowie an der Integration von Körper, Form, Alignment, Dynamik und Musikalität zu arbeiten. Die Teilnehmer*innen erhalten individuelle Förderung und Betreuung, mit dem Ziel die tänzerischen und kreativen Potentiale zu stärken, so dass ein erfolgreicher Ausbildungsweg eingeschlagen werden kann. 
<br /><br />
Es werden 6 Leistungsklassen pro Woche in der Regel von Mo-Do 12:00-14:00 Uhr oder 14:30-16:30 Uhr und Fr 12:00-16:30 Uhr angeboten. Diese sind obligatorisch und ausschließlich für die Dance Intensive-Teilnehmer*innen. Daneben können alle weiteren Kurse des offenen Kursprogramms der Tanzfabrik besucht werden. Das Angebot des regulären Kursprogramms beinhaltet u.a. die Fächer Contemporary, Contemporary Ballett, Contact Improvisation, Gaga, Dynamic Improvisation, Movement Research, Axis Syllabus, Afrikanischer Tanz, Contemporary Jazz, Streetdance, Yoga, Body- Mind Centering, Pilates, Feldenkrais, Butoh, Urban Flow. 
<br /><br />
Der Schwerpunkt der Leistungsklassen liegt auf der Vermittlung von zeitgenössischen Tanztechniken und Stilen, der Körperarbeit (Körperwahrnehmungstechniken/angewandte Anatomie) und der Improvisation/Komposition. Zudem wird Unterricht in zeitgenössischem Ballett und Theorieklassen angeboten. Während der Ausbildung werden die Teilnehmer*innen an mehreren Aufführungen mitwirken. Unter der Leitung der Dozent*innen werden Gruppenprojekte erarbeitet sowie die Möglichkeit geboten, mit Unterstützung der Ausbildungsleiterin, eigene Stücke zu realisieren. Außerdem erhalten die Teilnehmer*innen Unterstützung bei der Erstellung ihrer Bewerbungsunterlagen. Neben der regelmäßigen Unterrichtsteilnahme erhalten die Teilnehmer*Innen einen Einblick in den tänzerischen Alltag und können die Veranstaltungen der Tanzfabrik Berlin kostenlos besuchen.
RICHCONTENT1

make_module({
  module_type: "page_intro",
  section: "schule",
  headline_de: "Dance In\\tensive",
  headline_en: "Dance In\\tensive",
  special_text_de: special_text.strip,
  special_text_en: special_text.strip,
  rich_content_1_de: rich_content_1,
  rich_content_1_en: rich_content_1,
}, img_landscape)

### page_intro / Performance Projekte (ohne Bild!!)

make_module({
  module_type: "page_intro",
  section: "schule",
  headline_de: "Performance Projekte",
  headline_en: "Performance Projekte",
}, false, pdf)

### page_intro / Kontakt (ohne Bild!! ohne PDF!! Nur HEADLINE!!)

make_module({
  module_type: "page_intro",
  section: "schule",
  headline_de: "Kontakt",
  headline_en: "Contact",
})

### page_intro / Headline und Text (kein Bild)

make_module({
  module_type: "page_intro",
  section: "schule",
  headline_de: "Kursplan",
  headline_en: "Kursplan",
  special_text_de: special_text.strip,
  special_text_en: special_text.strip,
  rich_content_1_de: rich_content_1,
  rich_content_1_en: rich_content_1,  
})


### page_intro_magazine / Twists: Dance and Decoloniality (Magazin!)

rich_content_1 = <<~RICHCONTENT1
Die Tanzfabrik Berlin bietet für alle, die sich intensiv mit Tanz beschäftigen möchten, ein zehnmonatiges Dance Intensive- Programm an. Dance Intensive ist ein Qualifizierungsprogramm, das sich an Personen richtet, die sich im Bereich Tanz orientieren, weiterbilden und/oder sich auf Aufnahmeprüfungen an unterschiedlichen nationalen und internationalen Ausbildungsinstituten vorbereiten möchten. Das Programm bietet die Möglichkeit der Orientierung im Bereich Zeitgenössischer Tanz und bietet Einblick in Tanzrichtungen und Tanzstile um sich gezielt auf eine zukünftige Ausbildung vorzubereiten (das Vortanzen an Hochschulen und Instituten) oder die Integration des erlernten Wissens in bestehende Berufsbereiche. Ziel des Qualifizierungsprogramms ist es, ein Fundament in tänzerischen Disziplinen und Techniken zu legen sowie an der Integration von Körper, Form, Alignment, Dynamik und Musikalität zu arbeiten. Die Teilnehmer*innen erhalten individuelle Förderung und Betreuung, mit dem Ziel die tänzerischen und kreativen Potentiale zu stärken, so dass ein erfolgreicher Ausbildungsweg eingeschlagen werden kann. 
<br /><br />
Es werden 6 Leistungsklassen pro Woche in der Regel von Mo-Do 12:00-14:00 Uhr oder 14:30-16:30 Uhr und Fr 12:00-16:30 Uhr angeboten. Diese sind obligatorisch und ausschließlich für die Dance Intensive-Teilnehmer*innen. Daneben können alle weiteren Kurse des offenen Kursprogramms der Tanzfabrik besucht werden. Das Angebot des regulären Kursprogramms beinhaltet u.a. die Fächer Contemporary, Contemporary Ballett, Contact Improvisation, Gaga, Dynamic Improvisation, Movement Research, Axis Syllabus, Afrikanischer Tanz, Contemporary Jazz, Streetdance, Yoga, Body- Mind Centering, Pilates, Feldenkrais, Butoh, Urban Flow. 
<br /><br />
Der Schwerpunkt der Leistungsklassen liegt auf der Vermittlung von zeitgenössischen Tanztechniken und Stilen, der Körperarbeit (Körperwahrnehmungstechniken/angewandte Anatomie) und der Improvisation/Komposition. Zudem wird Unterricht in zeitgenössischem Ballett und Theorieklassen angeboten. Während der Ausbildung werden die Teilnehmer*innen an mehreren Aufführungen mitwirken. Unter der Leitung der Dozent*innen werden Gruppenprojekte erarbeitet sowie die Möglichkeit geboten, mit Unterstützung der Ausbildungsleiterin, eigene Stücke zu realisieren. Außerdem erhalten die Teilnehmer*innen Unterstützung bei der Erstellung ihrer Bewerbungsunterlagen. Neben der regelmäßigen Unterrichtsteilnahme erhalten die Teilnehmer*Innen einen Einblick in den tänzerischen Alltag und können die Veranstaltungen der Tanzfabrik Berlin kostenlos besuchen.
RICHCONTENT1

make_module({
  module_type: "page_intro_magazine",
  section: "buehne",
  headline_de: "Twists: Dance and De\\colonia\\lity",
  headline_en: "Twists: Dance and De\\colonia\\lity",
  sub_de: "40 Jahre Tanzfabrik",
  sub_en: "40 Jahre Tanzfabrik",
}, img_landscape)


### content_2_columns

rich_content_1 = <<~RICHCONTENT
Das Bewerbungsformular steht oben auf dieser Seite zum Download bereit. Bitte ausfüllen und als scan (pdf oder jpeg) zusammen mit den anderen Dokumenten an obige e-mail Adresse senden. Bewerbungen bitte nur als e-mail schicken. 
<br />
<br />
Um in das Programm aufgenommen zu werden, ist die Teilnahme am Aufnahmeverfahren erforderlich. 
<br />
<br />
Bitte sende Deine Bewerbung spätestens bis zur jeweiligen angegebenen Bewerbungsfrist. Bewerbungen, die danach geschickt werden, können nicht berücksichtigt werden. Es wird empfohlen, sich frühzeitig zu bewerben. Eine Bestätigung über einen Platz im Aufnahmeverfahren erfolgt per e-mail. Die Gebühr für das Aufnahmeverfahren beträgt 20 € und muss am ersten Tag des Wochenendes bar bezahlt werden. 
<br />
<br />
Alle Teilnehmer*innen werden inerhalb von zwei Wochen nach dem Aufnahmeverfahren informiert, ob sie in das Programm aufgenommen wurden. Die Entscheidung über die Aufnahme der Bewerber/innen liegt bei der Tanzfabrik. 
<br />
<br />
Erforderlich für die Aufnahme sind eine abgeschlossene Schulausbildung und ein Mindestalter von 18 Jahren. Nach oben gibt es grundsätzlich keine Grenze für das Eintrittsalter. Bei einer Aufnahme in das Programm sind eine Bescheinigung über Sportgesundheit und Zeugniskopien einzureichen.
<br />
<br />
<br />
Weitere Fragen zum Dance Intensive Programm, beantworten wir gerne per e-mail: <br />
Tanzfabrik Berlin <br />
Assistenz/Dance Intensive-Programm <br />
Möckernstraße 68 <br />
D-10965 Berlin <br />
danceintensive@tanzfabrik-berlin.de<br />
RICHCONTENT

rich_content_2 = <<~RICHCONTENT2
<h4>↪ Termine</h4>
Sa 04. und So 05.04.2020<br />
(Bewerbungsfrist am 23.02) 
<br />
<br />
Sa 25. und So 26.04.2020<br />
(Bewerbungsfrist am 22.03)
<br />
<br />
Sa 16. und So 17.05.2020<br />
(Bewerbungsfrist am 19.04) 
<br />
<br />
Sa 04. und So 05.07.2020<br />
(Bewerbungsfrist am 24.05)
<br />
<br />
<h4>↪ Aufnahmeverfahren</h4>
Das Aufnahmeverfahren findet jeweils an einem Wochenende (Samstag + Sonntag) in der Tanzfabrik Kreuzberg statt. Das Wochenende setzt sich aus einem Informationsgespräch, der Teilnahme an drei unterschiedlichen Contemporary Klassen sowie einem persönlichen Gespräch zusammen.
RICHCONTENT2

make_module({
  module_type: "content_2_columns",
  section: "schule",
  headline_de: "Bewerbung",
  headline_en: "Application",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
  rich_content_2_de: rich_content_2,
  rich_content_2_en: "",
}, nil, pdf)


### content_element / Open Spaces

special_text = <<~SPECIALTEXT
Tanzdokumentation als künstlerische Praxis 
Ein TANZFONDS ERBE Projekt 
Projektzeitraum: Juni 2015 bis Juli 2016
SPECIALTEXT

rich_content_1 = <<~RICHCONTENT1
Das Projekt “Capturing Dance - Tanzdokumentation als künstlerische Praxis” richtet erstmals einen künstlerischen und damit neuen Fokus auf den Umgang mit Tanzdokumentation und versucht ihn mit einer jüngeren Künstlergeneration exemplarisch in Berlin und Köln umzusetzen. Ein Symposium (16.-17.10.2015), ein Labor (Januar 2016) und eine Ausstellung (Juni 2016) bieten hierfür den Rahmen, in dem Student_innen des Hochschulübergreifendem Zentrums für Tanz Berlin (HZT) und der Kunsthochschule für Medien Köln (KHM) sowie professionelle Kolleg_innen die Wechselbeziehung zwischen Choreografie, Performance und Dokumentation beleuchten können. 
<br /><br />
www.capturingdance.de
RICHCONTENT1

make_module({
  module_type: "content_element",
  section: "schule",
  headline_de: "Open Spaces",
  headline_en: "Open Spaces",
  special_text_de: special_text.strip,
  special_text_en: "",      
  rich_content_1_de: rich_content_1,
}, img_landscape)

### content_element / Tanznacht Berlin

#special_text = <<~SPECIALTEXT
#Tanzdokumentation als künstlerische Praxis 
#Ein TANZFONDS ERBE Projekt 
#Projektzeitraum: Juni 2015 bis Juli 2016
#SPECIALTEXT

rich_content_1 = <<~RICHCONTENT1
Eine kritische Recherche über Tanzinstitutionen von und mit Tanzfabrik Berlin in Kooperation mit ada Studio, HZT Berlin, Uferstudios, Freie Universität und Humboldt Universität, beraten von Diversity Arts Culture. Das Projekt »Twists: Dance and Decoloniality« wirft systematisch die Frage nach den Auswirkungen des Kolonialismus im Tanz auf. Am Beispiel der Tanzfabrik Berlin sowie von ada Studio, HZT Berlin und Uferstudios werden in einer institutionskritischen Recherche der Künstler*innen Choy Ka Fai, Jay Pather, Lia Rodrigues, und Jessica Lauren Elizabeth Taylor bestehende Hegemonien, Rassismen und Exklusionen innerhalb der etablierten Produktionsbedingungen im Tanz aufgezeigt. Das Projekt trägt aktuelles Wissen aus
RICHCONTENT1

#rich_content_2 = <<~RICHCONTENT2
#Zur Vermeidung von Verletzungen bitte beachten: High Level insbesondere bei den Trainings von Stella Zannou und Blenard Azizaj.<br />
#<br />
#Kein Training während der Workshops, an gesetzlichen Feiertagen und in den Ferien der Tanzfabrik. Um an anderen Tanzklassen der Tanzfabrik teilzunehmen, können Tanzprofis auf Anfrage eine 10er Karte zu 65 € (10 x 75 Min.), zu 80 € (10 x 90 Min.), 95 € (10 x 120 Min.) erwerben.
#RICHCONTENT2


make_module({
  module_type: "content_element",
  section: "buehne",
  headline_de: "Tanznacht Berlin",
  headline_en: "Tanznacht Berlin",
  special_text_de: "",
  special_text_en: "",      
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
}, img_landscape)

### content_element / Werde Teil der Tanzfabrik!

rich_content_1 = <<~RICHCONTENT1
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.
RICHCONTENT1

make_module({
  module_type: "content_element",
  section: "buehne",
  headline_de: "Werde Teil der Tanzfabrik!",
  headline_en: "Werde Teil der Tanzfabrik!",
  special_text_de: "",
  special_text_en: "",      
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
}, img_portrait)

### content_element_magazine / This specific generative history

rich_content_1 = <<~RICHCONTENT1
This specific generative history, which you can learn much more about in the following pages, as well as the profound changes that Tanzfabrik Berlin has witnessed over the last 40 years have resulted in a structure that is much more flexible, albeit fragile. 
On the one hand, this flexibility is a powerful resource that allows adaptation and reaction in different times and circumstances, thus avoiding the rigidity that often results as a function of institutionalisation. On the other hand, it places Berlin’s oldest institution for contemporary dance in a state of constant precariousness. 
Even today in 2018, amidst focused political efforts intended to help Berlin’s contemporary dance community organise itself structurally through the formation of a Dance Round Table Berlin, Tanzfabrik Berlin continues to work to come to terms with private responsibility, political marginalisation and a lack of infrastructural funding.
RICHCONTENT1

make_module({
  module_type: "content_element_magazine",
  section: "schule",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: rich_content_1,
})

### content_element_magazine / Tanzfabrik Berlin has served

rich_content_1 = <<~RICHCONTENT1
Tanzfabrik Berlin has served as house for contemporary dance in Berlin since 1978. Initiated by a visionary group of artists with the simple goal of “living and working” together when Berlin was still divided by the Berlin Wall, Tanzfabrik Berlin has developed itself into an internationally renowned production center that welcomes thousands of artists, students and dance lovers to its studios each year.
RICHCONTENT1

make_module({
  module_type: "content_element_magazine",
  section: "schule",
  style_option: "large_left",  
  rich_content_1_de: rich_content_1,
  rich_content_1_en: rich_content_1,
})

### content_element_magazine / Weit hinten

rich_content_1 = <<~RICHCONTENT1
Weit hinten, hinter den Wortbergen, fern der Länder Vokalien und Konsonantien leben die Blindtexte. Abgeschieden wohnen sie in Buchstabhausen an der Küste des Semantik, eines großen Sprachozeans.
RICHCONTENT1

make_module({
  module_type: "content_element_magazine",
  section: "schule",
  style_option: "large_right",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: rich_content_1,
})

### content_element_magazine / ↪#1

rich_content_1 = <<~RICHCONTENT1
<h4>↪ #1</h4>
Teilresidenzen ermöglichen zum einen den Erstkontakt mit der Tanzfabrik Berlin und ersten Austausch über Arbeitsweisen und Erfordernisse sowie eine informelle öffentliche Präsentation der Arbeit. Die Raumkosten werden mit 50% der Betriebskosten unterstützt. Die Präsentation wird durch die Öffentlichkeitsarbeit der Tanzfabrik Berlin kommuniziert.
RICHCONTENT1

make_module({
  module_type: "content_element_magazine",
  section: "buehne",
  style_option: "centered",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: rich_content_1,
})

### reference / identifying a physical script

special_text = <<~SPECIALTEXT
06.01.2020 – 19.02.2020, Wedding 3
SPECIALTEXT

rich_content_1 = <<~RICHCONTENT1
<b>Workshop</b> mit Igor Dobricic, Guillaume Marie, Roger Sala Reyner
RICHCONTENT1

make_module({
  module_type: "reference",
  section: "buehne",
  headline_de: "Identifying a physical script",
  headline_en: "Identifying a physical script",
  special_text_de: special_text.strip,
  special_text_en: "",      
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
  link_title_de: "Tanznacht",
  link_title_en: "Tanznacht",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",    
}, img_landscape)

### reference / Unsere Tanzklassen

make_module({
  module_type: "reference",
  section: "schule",
  headline_de: "Unsere Tanzklassen",
  headline_en: "Unsere Tanzklassen",
  sub_de: "Anfänger bis Profi",
  sub_en: "Anfänger bis Profi",
  link_title_de: "Tanznacht",
  link_title_en: "Tanznacht",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",     
}, img_landscape)

### reference / Tanznacht Berlin 2020

make_module({
  module_type: "reference",
  section: "festival",
  headline_de: "Tanznacht Berlin 2020",
  headline_en: "Tanznacht Berlin 2020",
  sub_de: "Age of Displacement until the new line",
  sub_en: "Age of Displacement until the new line",
  link_title_de: "Tanznacht",
  link_title_en: "Tanznacht",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",  
}, img_landscape)

### slideshow / Upcoming Workshops

image_attributes = {
  super_de: "Roberto Olivian",
  super_en: "Roberto Olivian",
  headline_de: "Instinct as a source of movement",
  headline_en: "Instinct as a source of movement",
  rich_content_1_de: "<b>Workshop</b> mit Igor Dobricic, Guillaume Marie, Roger Sala Reyner",
  rich_content_1_en: "<b>Workshop</b> mit Igor Dobricic, Guillaume Marie, Roger Sala Reyner",
  link_title_de: "Zum Workshop",
  link_title_en: "Zum Workshop",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",    
}

images = [
  img_landscape.merge(image_attributes),
  img_square.merge(image_attributes),
  img_portrait.merge(image_attributes),
  img_landscape.merge(image_attributes),
  img_square.merge(image_attributes),
  img_portrait.merge(image_attributes),  
]

make_module({
  module_type: "slideshow",
  section: "schule",
  headline_de: "Upcoming Workshops",
  headline_en: "Upcoming Workshops",
  link_title_de: "Workshops",
  link_title_en: "Workshops",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",  
}, [images])


# video module / youtube

make_module({
  module_type: "video",
  section: "schule",
  headline_de: "Video Youtube",
  headline_en: "Video Youtube",
  parameter: "https://www.youtube.com/watch?v=5inySyAPVOw",
  link_title_de: "Watch this",
  link_title_en: "Watch this",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",    
})

# video module / vimeo

make_module({
  module_type: "video",
  section: "schule",
  headline_de: "Video Vimeo",
  headline_en: "Video Vimeo",
  parameter: "https://vimeo.com/415570097",
  link_title_de: "Watch this",
  link_title_en: "Watch this",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",    
})

# today module

make_module({
  module_type: "today",
  section: "schule",
  headline_de: "Heute",
  headline_en: "Today",
})

# newsletter module / schule

make_module({
  module_type: "newsletter",
  section: "schule",
  headline_de: "Alle Highlights in unserem Newsletter!",
  headline_en: "Alle Highlights in unserem Newsletter!",
})

# newsletter module / buehne

make_module({
  module_type: "newsletter",
  section: "buehne",
  headline_de: "Alle Highlights in unserem Newsletter!",
  headline_en: "Alle Highlights in unserem Newsletter!",
})


# image element magzine module

rich_content_1 = <<~RICHCONTENT1
Weit hinten, hinter den Wortbergen, fern der Länder Vokalien und Konsonantien leben die Blindtexte. Abgeschieden wohnen sie in Buchstabhausen an der Küste des Semantik, eines großen Sprachozeans. Ein kleines Bächlein namens Duden fließt durch ihren Ort und versorgt sie mit den nötigen Regelialien. Es ist ein paradiesmatisches Land, in dem einem gebratene Satzteile in den Mund fliegen. Nicht einmal von der allmächtigen Interpunktion werden die Blindtexte beherrscht – ein geradezu unorthographisches Leben. Eines Tages aber beschloß eine kleine Zeile Blindtext, ihr Name war Lorem Ipsum, hinaus zu gehen in die weite Grammatik. Der große Oxmox riet ihr davon ab, da es dort wimmele von bösen Kommata, wilden Fragezeichen und hinterhältigen Semikoli, doch das Blindtextchen ließ sich nicht beirren. Es packte seine sieben Versalien, schob sich sein Initial in den Gürtel und machte sich auf den Weg. Als es die ersten Hügel des Kursivgebirges erklommen hatte, warf es einen letzten Blick zurück auf die Skyline seiner Heimatstadt Buchstabhausen, die Headline von Alphabetdorf und die Subline seiner eigenen Straße, der Zeilengasse. Wehmütig lief ihm eine rhetorische Frage über die Wange, dann setzte es seinen Weg fort. Unterwegs traf es eine Copy. Die Copy warnte das Blindtextchen, da, wo sie herkäme wäre sie
RICHCONTENT1

make_module({
  module_type: "image_element_magazine",
  section: "fabrik",
  headline_de: "1990",
  headline_en: "1990",
  rich_content_1_de: rich_content_1,
  rich_content_1_en: "",
}, img_landscape)


# festival_logos / 

image_attributes1 = {
  headline_de: "Ein Projekt der Tanzfabrik Berlin",
  headline_en: "links",
  description: "logo",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/", 
}

image_attributes2 = {
  headline_de: "Gefördert durch",
  headline_en: "mitte",
  description: "logo", 
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",   
}

image_attributes3 = {
  headline_de: "Kooperationspartner",
  headline_en: "rechts",
  description: "logo",
  link_href_de: "http://tanznachtberlin.de/",
  link_href_en: "http://tanznachtberlin.de/",   
}

images = [
  img_landscape.merge(image_attributes1),
  img_square.merge(image_attributes2),
  img_portrait.merge(image_attributes3),
  img_landscape.merge(image_attributes3),
  img_square.merge(image_attributes3),
  img_landscape.merge(image_attributes3),
]

make_module({
  module_type: "festival_logos",
  section: "buehne",
}, [images])

# END

end

