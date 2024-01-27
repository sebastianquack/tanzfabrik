require_relative '../../app/services/ms_graph_client'
require 'date'

# This task is currently used for development
# It will later be used to import existing outlook calendar events into the database in the next PR

desc 'imports outlook calendar events to database'
task :run_ms_graph => :environment do

  tenant_id = ENV["MS_TENANT_ID"]
  client_id = ENV["MS_APP_CLIENT_ID"]
  client_secret = ENV["MS_APP_CLIENT_SECRET"]
  principal = ENV["MS_PRINCIPAL"]

  scope = ['https://graph.microsoft.com/.default']

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

  # calendars = ms_graph_client.get_calendars(principal)
  # calendar_id = calendars[0]["id"]
  
  # Studio 1 rails id: 980190971
  # Studio 1 outlook id
  calendar_id = "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAEGAAAkY2c3scT4QYtAGWXhfBH4AAAS2I3SAAA="
  
  now = Time.now.strftime("%Y-%m-%dT%H:%M:%SZ")
  one_month_from_now = Date.today >> 1
  one_month_from_now = Time.utc(one_month_from_now.year, one_month_from_now.month, one_month_from_now.day, 0, 0, 0)

  events = ms_graph_client.get_events(principal, calendar_id, now, one_month_from_now)
  event_id = events[0]["id"]

  event = ms_graph_client.get_event(principal, event_id)

  data = {
    "ref_id" => event["id"],
    "body" =>  event["bodyPreview"],
    "start_time" => event["start"]["dateTime"],
    "end_time" => event["end"]["dateTime"],
    "calendar_id" => calendar_id
  }
  puts events.size
end