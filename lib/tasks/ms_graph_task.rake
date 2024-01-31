require_relative '../../app/services/ms_graph_client'
require 'date'

# This task is currently used for development
# It will later be used to import existing outlook calendar events into the database in the next PR

desc 'script used to discover the ms graph environment'
task :run_ms_graph => :environment do

  tenant_id = ENV["MS_TENANT_ID"]
  client_id = ENV["MS_APP_CLIENT_ID"]
  client_secret = ENV["MS_APP_CLIENT_SECRET"]
  principal = ENV["MS_PRINCIPAL"]
  calendar_id = "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAEGAAAkY2c3scT4QYtAGWXhfBH4AAAS2I3SAAA="
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
  puts calendars
  # calendar_id = calendars[0]["id"]

  # Studio 1 rails id: 980190971
  # Studio 1 outlook id
  
  events = ms_graph_client.get_events(principal, calendar_id, from, to)
  # CalendarEvent.delete_all()
  events.each do |event|
    data = {
      "ref_id" => event["id"],
      "body" =>  event["bodyPreview"],
      "subject" => event["subject"],
      "start_time" => event["start"]["dateTime"],
      "end_time" => event["end"]["dateTime"],
      "calendar_id" => calendar_id
    }

    event = CalendarEvent.new(
      start_time: data["start_time"],
      end_time: data["end_time"],
      description: data["description"],
      subject: data["subject"],
      calendar_id: 1
    )
    event.save()
  end
  puts events.size
end

def to_iso_date(date)
  Time.utc(date.year, date.month, date.day, 0, 0, 0).strftime("%Y-%m-%dT%H:%M:%S")
end