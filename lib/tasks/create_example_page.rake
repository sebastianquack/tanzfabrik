desc 'create example page containing all modules'
task :create_example_page => :environment do

  begin
    existing_page = Page.find("module")
    existing_page.delete
  rescue ActiveRecord::RecordNotFound
    # no problem
  end

  p = Page.create(
    title_de: "Module",
    title_en: "Modules"
  )

  if p.errors
    puts p.errors.full_messages
  end

  counter = 1

  # BEGIN

  ### media_text_2_colums

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
<h4>Termine</h4>
<br />
<br />
Sa 04. und So 05.04.2020 (Bewerbungsfrist am 23.02) 
<br />
Sa 25. und So 26.04.2020 (Bewerbungsfrist am 22.03)
<br />
Sa 16. und So 17.05.2020 (Bewerbungsfrist am 19.04) 
<br />
Sa 04. und So 05.07.2020 (Bewerbungsfrist am 24.05)
<br />
<br />
<h4>Aufnahmeverfahren</h4>
<br />
Das Aufnahmeverfahren findet jeweils an einem Wochenende (Samstag + Sonntag) in der Tanzfabrik Kreuzberg statt. Das Wochenende setzt sich aus einem Informationsgespräch, der Teilnahme an drei unterschiedlichen Contemporary Klassen sowie einem persönlichen Gespräch zusammen.
RICHCONTENT2

  cm = ContentModule.create({
      page_id: p.id,
      module_type: "media_text_2_colums",
      headline_de: "Bewerbung",
      headline_en: "Application",
      rich_content_1_de: rich_content_1,
      rich_content_1_en: "",
      rich_content_2_de: rich_content_2,
      rich_content_2_en: "",
      order: counter += 1
  })


### page_intro / Workshops

rich_content_1 = <<~RICHCONTENT1
Die Übersicht über Workshops sind im dazugehörigen PDF zu finden
RICHCONTENT1

  cm = ContentModule.create({
      page_id: p.id,
      module_type: "page_intro",
      headline_de: "Work&shy;shops",
      headline_en: "Work&shy;shops",
      rich_content_1_de: rich_content_1,
      rich_content_1_en: "",
      order: counter += 1
  })

### page_intro / Profiklassen

#spacial_text = <<~SPECIALTEXT
#1 Klasse á 90 Minuten: 7 € / 10er Karte: 65 €<br />
#1 Klasse á 120 Minuten: 8,50 € / 10er Karte: 65 € +1 € pro 120 Min.-Klasse.
#SPECIALTEXT

rich_content_1 = <<~RICHCONTENT1
1 Klasse á 90 Minuten: 7 € / 10er Karte: 65 €<br />
1 Klasse á 120 Minuten: 8,50 € / 10er Karte: 65 € +1 € pro 120 Min.-Klasse.
RICHCONTENT1

rich_content_2 = <<~RICHCONTENT2
Zur Vermeidung von Verletzungen bitte beachten: High Level insbesondere bei den Trainings von Stella Zannou und Blenard Azizaj.<br />
<br />
Kein Training während der Workshops, an gesetzlichen Feiertagen und in den Ferien der Tanzfabrik. Um an anderen Tanzklassen der Tanzfabrik teilzunehmen, können Tanzprofis auf Anfrage eine 10er Karte zu 65 € (10 x 75 Min.), zu 80 € (10 x 90 Min.), 95 € (10 x 120 Min.) erwerben.
RICHCONTENT2

  cm = ContentModule.create({
      page_id: p.id,
      module_type: "page_intro",
      headline_de: "Profi&shy;klassen",
      headline_en: "Profi&shy;klassen",
      rich_content_1_de: rich_content_1,
      rich_content_1_en: "",
      rich_content_2_de: rich_content_2,
      rich_content_2_en: "",      
      order: counter += 1
  })

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

#rich_content_2 = <<~RICHCONTENT2
#Zur Vermeidung von Verletzungen bitte beachten: High Level insbesondere bei den Trainings von Stella Zannou und Blenard Azizaj.<br />
#<br />
#Kein Training während der Workshops, an gesetzlichen Feiertagen und in den Ferien der Tanzfabrik. Um an anderen Tanzklassen der Tanzfabrik teilzunehmen, können Tanzprofis auf Anfrage eine 10er Karte zu 65 € (10 x 75 Min.), zu 80 € (10 x 90 Min.), 95 € (10 x 120 Min.) erwerben.
#RICHCONTENT2

  cm = ContentModule.create({
      page_id: p.id,
      module_type: "page_intro",
      headline_de: "Dance Intensive",
      headline_en: "Dance Intensive",
      special_text_de: special_text,
      special_text_en: "",      
      rich_content_1_de: rich_content_1,
      rich_content_1_en: "",
      rich_content_2_de: "",
      rich_content_2_en: "",      
      order: counter += 1
  })



# END

end

