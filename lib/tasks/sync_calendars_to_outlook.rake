require_relative '../../app/services/ms_graph_client'
require 'date'

# This task is currently used for development
# It will later be used to import existing outlook calendar events into the database in the next PR

desc 'imports outlook calendar events to database'
task :sync_calendars_to_outlook => :environment do

  tenant_id = ENV["MS_TENANT_ID"]
  client_id = ENV["MS_APP_CLIENT_ID"]
  client_secret = ENV["MS_APP_CLIENT_SECRET"]
  principal = ENV["MS_PRINCIPAL"]
  scope = ['https://graph.microsoft.com/.default']

  ms_graph_client = MsGraphClient.new(tenant_id, client_id, client_secret, scope)
  CalendarEvent.delete_all

  studios_config = {
    studio_one: {
      internal_id: 980190971,
      outlook_calendar_id: "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAEGAAAkY2c3scT4QYtAGWXhfBH4AAAS2I3SAAA=",
      availabilities: {
        two_hour_rehearsal: {
          bookable_months_in_advance: 2,
          schedule: {
            monday: {from: '9', to: '16'},
            tuesday: {from: '9', to: '16'},
            wednesday: {from: '9', to: '16'},
            thursday: {from: '9', to: '16'},
            friday: {from: '9', to: '16'},
          }
        },
      }
    },
    studio_three: {
      internal_id: 980190963,
      outlook_calendar_id: "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAEGAAAkY2c3scT4QYtAGWXhfBH4AAAS2I3TAAA=",
      availabilities: {
        two_hour_rehearsal: {
          bookable_months_in_advance: 2,
          schedule: {
            monday: {from: '9', to: '16'},
            tuesday: {from: '9', to: '16'},
            wednesday: {from: '9', to: '16'},
            thursday: {from: '9', to: '16'},
            friday: {from: '9', to: '16'},
          }
        },
      } 
    },
    studio_four: {
      internal_id: 980190966,
      outlook_calendar_id: "AAMkAGQzZTQ3NDlkLTkzNGYtNGVhOC04NmFiLTA1NzI2M2M5YTRlOQBGAAAAAACUojf8eQYPSpPKOfgiTlKLBwAkY2c3scT4QYtAGWXhfBH4AAAAAAEGAAAkY2c3scT4QYtAGWXhfBH4AAAS2I3UAAA=",
      availabilities: {
        two_hour_rehearsal: {
          bookable_months_in_advance: 2,
          schedule: {
            friday: {from: '16', to: '21'},
            saturday: {from: '9', to: '21'},
            sunday: {from: '9', to: '21'},
          }
        },
      } 
    }
  }

  studios_config.each do |studio_name, config|
    calendar = Calendar.find_or_initialize_by(name: studio_name)
    calendar.update_attributes({
      outlook_id: config[:outlook_calendar_id], 
      studio_id: config[:internal_id]
    })
    calendar.booking_types = []
    calendar.save

    config[:availabilities].each do |booking_type, calendar_booking_type_config|
      booking_type = get_booking_type(booking_type)
      calendar.booking_types << booking_type
      calendar_booking_type = CalendarBookingType.where(calendar: calendar, booking_type: booking_type).first
      calendar_booking_type.settings = calendar_booking_type_config
      calendar_booking_type.save
      calendar.save
    end

    from = to_iso_date(Date.today)
    to = to_iso_date(Date.today >> 12)
    events = ms_graph_client.get_events(principal, config[:outlook_calendar_id], from, to)

    events.each do |event|
      event = CalendarEvent.new(
        start_time: event["start"]["dateTime"],
        end_time: event["end"]["dateTime"],
        description: event["description"],
        subject: event["subject"],
        calendar_id: calendar.id
      )
      event.save()
    end
    puts "#{studio_name}: #{events.size} events until #{to}."  
  end
end

def get_booking_type(booking_type_name)
  case booking_type_name
  when :two_hour_rehearsal
    return BookingType.two_hour_rehearsal()
  end
end

def to_iso_date(date)
  Time.utc(date.year, date.month, date.day, 0, 0, 0).strftime("%Y-%m-%dT%H:%M:%S")
end