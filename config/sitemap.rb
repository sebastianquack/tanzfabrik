# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.tanzfabrik-berlin.de"

SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do

  #I18n.locale = :en

  languages = [:de, :en]

  languages.length.times do |i|

    language0 = languages[i]
    language1 = languages[i-1]

    Page.all.each do |page|
      priority = page.priority ? page.priority : 0.5
      changefreq = page.changefreq ? page.changefreq : 'monthly'
      add page_path(page, :locale => language0 ), 
        :lastmod => page.updated_at, 
        :changefreq => changefreq, 
        :priority => priority,
        :alternate => {
          :href => page_path(page, :locale => language1 ),
          :lang => language1
        }
    end

    Festival.all.each do |festival|
      changefreq = (festival.start_date && festival.start_date >= Date.today) ? 'weekly' : 'never'
      priority = (festival.end_date && festival.end_date >= Date.today) ? 0.6 : 0.3
      add festival_path(festival, :locale => language0), 
        :lastmod => festival.updated_at, 
        :changefreq => changefreq,
        :priority => priority,
        :alternate => {
          :href => page_path(festival, :locale => language1 ),
          :lang => language1
        }        
    end

    Event.all.have_own_page.each do |event|
      priority = (event.event_details.length > 0 && event.end_date >= Date.today) ? 0.5 : 0.3
      add event_path(event, :locale => language0), 
        :lastmod => event.updated_at, 
        :changefreq => 'never', 
        :priority => priority,
        :alternate => {
          :href => page_path(event, :locale => language1 ),
          :lang => language1
        }        
    end

  end

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
