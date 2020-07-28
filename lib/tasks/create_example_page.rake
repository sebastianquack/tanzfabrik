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
      order: 1
  })

end

