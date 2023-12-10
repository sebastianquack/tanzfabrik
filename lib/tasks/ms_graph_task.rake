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

  calendars = ms_graph_client.get_calendars(principal)
  calendar_id = calendars[0]["id"]
  
  events = ms_graph_client.get_events(principal, calendar_id)
  event_id = events[0]["id"]

  event = ms_graph_client.get_event(principal, event_id)
  puts event
end