require_relative '../../app/services/ms_graph_client'

desc 'imports calendar events to database'
task :run_ms_graph => :environment do

  tenant_id = "2b07e5c4-cf90-4914-b15c-d83a785b1e5a"
  client_id = '7c7608bf-a091-4e6c-a5c1-301232ac6cb1'
  client_secret = '6nK8Q~9s22oDM3gh3.2C9O3PDTVqotYM5F76wb~-'
  scope = ['https://graph.microsoft.com/.default']
  
  tf_it_assistant_account_id = "81b196f3-676a-4027-ba78-d2b492ba3f88"
  tf_programmer_account_id = "19ed95de-aa88-42fd-aeed-a2549fe4f47e"
  studio_1_calendar_id = "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAEGAAAkY2c3scT4QYtAGWXhfBH4AAAS2I3SAAA="

  some_event_id = "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAS2CY4AAAkY2c3scT4QYtAGWXhfBH4AAAS2JHgAAA="

  ms_graph_client = MsGraphClient.new(tenant_id, client_id, client_secret, scope)

  some_event = ms_graph_client.get_event(tf_programmer_account_id, studio_1_calendar_id, some_event_id) 

  puts some_event
end

