require_relative '../../app/services/ms_graph_client'
require 'date'

desc 'imports calendar events to database'
task :run_ms_graph => :environment do

  tenant_id = ENV["MS_TENANT_ID"]
  client_id = ENV["MS_APP_CLIENT_ID"]
  client_secret = ENV["MS_APP_CLIENT_SECRET"]
  principal = ENV["MS_PRINCIPAL"]

  scope = ['https://graph.microsoft.com/.default']
  
  test_calendar_id = "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAEGAAAkY2c3scT4QYtAGWXhfBH4AAAVJolvAAA="
  some_event_id = "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAENAAAkY2c3scT4QYtAGWXhfBH4AAAVJpUtAAA="

  ms_graph_client = MsGraphClient.new(tenant_id, client_id, client_secret, scope)

  event_details = {
    "subject" => "Hello world",
    "body" => {
      "contentType" => "HTML",
      "content" => "Does noon time work for you?"
    },
    "start": {
      "dateTime" => DateTime.new(2023, 12, 10, 14, 30, 0).strftime("%Y-%m-%dT%H:%M:%S"),
      "timeZone" => "Central European Standard Time"
    },
    "end": {
      "dateTime" => DateTime.new(2023, 12, 10, 14, 30, 0).strftime("%Y-%m-%dT%H:%M:%S"),
      "timeZone" => "Central European Standard Time"
    },
    "allowNewTimeProposals": false
  }

  event = ms_graph_client.get_event(principal, some_event_id)
  puts event

end