# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.tanzfabrik-berlin.de"
SitemapGenerator::Sitemap.public_path = 'tmp/' # because of heroku's write-only filesystem

# store on S3
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  ENV['S3_TANZFABRIK_BUCKET'],
  aws_access_key_id: ENV['S3_KEY'], 
  aws_secret_access_key: ENV['S3_SECRET'], 
  aws_region: 'eu-west-1'
)
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "https://#{ENV['S3_TANZFABRIK_BUCKET']}.s3.amazonaws.com/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do

  #I18n.locale = :en

  languages = [:de, :en]

  languages.length.times do |i|

    language0 = languages[i]
    language1 = languages[i-1]

    Page.where.not(:slug => "start").each do |page|
      priority = page.priority ? page.priority : 0.5
      changefreq = page.changefreq ? page.changefreq : 'monthly'
      add page_path(page, :locale => language0 ), 
        :lastmod => page.updated_at, 
        :changefreq => changefreq, 
        :priority => priority,
        :alternate => {
          :href => page_url(page, :locale => language1, :host => SitemapGenerator::Sitemap.default_host ),
          :lang => language1
        }
    end

    #Festival.all.each do |festival|
    #  changefreq = (festival.start_date && festival.start_date >= Date.today) ? 'weekly' : 'never'
    #  priority = (festival.end_date && festival.end_date >= Date.today) ? 0.6 : 0.3
    #  add festival_path(festival, :locale => language0), 
    #    :lastmod => festival.updated_at, 
    #    :changefreq => changefreq,
    #    :priority => priority,
    #    :alternate => {
    #      :href => festival_url(festival, :locale => language1, :host => SitemapGenerator::Sitemap.default_host ),
    #      :lang => language1
    #    }        
    #end

    Event.all.have_own_page.each do |event|
      priority = (event.event_details.length > 0 && event.end_date >= Date.today) ? 0.5 : 0.3
      add event_path(event, :locale => language0), 
        :lastmod => event.updated_at, 
        :changefreq => 'never', 
        :priority => priority,
        :alternate => {
          :href => event_url(event, :locale => language1, :host => SitemapGenerator::Sitemap.default_host ),
          :lang => language1
        }        
    end

  Person.having_any_events.each do |person|
    priority = 0.7
    add person_path(person, :locale => language0), 
      :lastmod => person.updated_at, 
      :changefreq => 'monthly', 
      :priority => priority,
      :alternate => {
        :href => person_url(person, :locale => language1, :host => SitemapGenerator::Sitemap.default_host ),
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
