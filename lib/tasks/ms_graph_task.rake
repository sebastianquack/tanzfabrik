require_relative '../../app/services/ms_graph_client'
require 'date'

desc 'imports calendar events to database'
task :run_ms_graph => :environment do

  tenant_id = "2b07e5c4-cf90-4914-b15c-d83a785b1e5a"
  client_id = '7c7608bf-a091-4e6c-a5c1-301232ac6cb1'
  client_secret = '6nK8Q~9s22oDM3gh3.2C9O3PDTVqotYM5F76wb~-'
  scope = ['https://graph.microsoft.com/.default']
  
  tf_programmer_account_id = "19ed95de-aa88-42fd-aeed-a2549fe4f47e"
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

  # event = ms_graph_client.create_event(tf_programmer_account_id, test_calendar_id, event_details)
  event = ms_graph_client.get_event(tf_programmer_account_id, test_calendar_id, some_event_id)
  puts event

end

# {
#   "subject": "Let's go for lunch",
#   "body": {
#     "contentType": "HTML",
#     "content": "Does noon time work for you?"
#   },
#   "start": {
#       "dateTime": "2017-09-04T12:00:00",
#       "timeZone": "Pacific Standard Time"
#   },
#   "end": {
#       "dateTime": "2017-09-04T14:00:00",
#       "timeZone": "Pacific Standard Time"
#   },
#   "recurrence": {
#     "pattern": {
#       "type": "weekly",
#       "interval": 1,
#       "daysOfWeek": [ "Monday" ]
#     },
#     "range": {
#       "type": "endDate",
#       "startDate": "2017-09-04",
#       "endDate": "2017-12-31"
#     }
#   },
#   "location":{
#       "displayName":"Harry's Bar"
#   },
#   "attendees": [
#     {
#       "emailAddress": {
#         "address":"AdeleV@contoso.onmicrosoft.com",
#         "name": "Adele Vance"
#       },
#       "type": "required"
#     }
#   ],
#   "allowNewTimeProposals": true
# }