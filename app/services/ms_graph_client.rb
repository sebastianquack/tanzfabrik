require 'net/http'
require 'uri'
require 'json'

# API reference: https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0

class MsGraphClient
  @@login_url = "https://login.microsoftonline.com"
  @@ms_graph_url = "https://graph.microsoft.com/v1.0"
  @@token = nil
  @@last_authenticated_at = nil

  def initialize(tenant_id, client_id, client_secret, scopes)
    @tenant_id = tenant_id
    @client_id = client_id
    @client_secret = client_secret
    @scopes = scopes
  end

  def get_events(user_id, calendar_id, from, to)
    validate_date_range(from, to)
    auth_or_refresh_token()
    http_client = HttpClient.new()
    url = "#{@@ms_graph_url}/users/#{user_id}/calendars/#{calendar_id}/events?top=200"
    data = http_client.get(url, {
      "Authorization" => "Bearer #{@@token}",
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end

    next_pointer = data["@odata.nextLink"]

    events = [].concat(data["value"])
    while(!data.key?("error") && !next_pointer.nil?) do
      url = next_pointer
      data = http_client.get(url, {
        "Authorization" => "Bearer #{@@token}"
      })
      if data.key?("error")
        return {error: data["error"]["code"], message: data["error_description"]}
      end
      
      data["value"].each do |event|
        if !event["recurrence"].nil?
          recurrences = get_recurrences(user_id, calendar_id, event["id"], from, to)
          events.concat(recurrences)
        end
      end

      next_pointer = data["@odata.nextLink"]
      events.concat(data["value"])
    end
    return events
  end

  def get_recurrences(user_id, calendar_id, event_id, from, to)
    http_client = HttpClient.new()
    url = "#{@@ms_graph_url}/users/#{user_id}/calendars/#{calendar_id}/events/#{event_id}/instances?startDateTime=#{from}&endDateTime=#{to}&top=200"
    data = http_client.get(url, {
      "Authorization" => "Bearer #{@@token}",
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end

    next_pointer = data["@odata.nextLink"]
    events = [].concat(data["value"])

    while(!data.key?("error") && !next_pointer.nil?) do
      url = next_pointer
      data = http_client.get(url, {
        "Authorization" => "Bearer #{@@token}"
      })
      if data.key?("error")
        return {error: data["error"]["code"], message: data["error_description"]}
      end
      next_pointer = data["@odata.nextLink"]
      events.concat(data["value"])
    end
    return events
  end

  def get_event(user_id, event_id)
    auth_or_refresh_token()
    url = "#{@@ms_graph_url}/users/#{user_id}/events/#{event_id}"
    http_client = HttpClient.new()
    data = http_client.get(url, {
      "Authorization" => "Bearer #{@@token}"
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end
    return data
  end

  def create_event(user_id, calendar_id, event_details)
    auth_or_refresh_token()
    url_stub = "#{@@ms_graph_url}/users/#{user_id}/calendar/events"
    http_client = HttpClient.new()
    data = http_client.post(url_stub, event_details, {
      "Authorization" => "Bearer #{@@token}",
      "Content-Type" => "application/json"
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end
    return data
  end

  def get_calendars(user_id)
    auth_or_refresh_token()
    url_stub = "#{@@ms_graph_url}/users/#{user_id}/calendars"
    http_client = HttpClient.new()
    data = http_client.get(url_stub, {
      "Authorization" => "Bearer #{@@token}"
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end
    return data["value"]
  end

  private

  def authenticate
    http_client = HttpClient.new()
    data = http_client.post("#{@@login_url}/#{@tenant_id}/oauth2/v2.0/token", {
      client_id: @client_id,
      client_secret: @client_secret,
      scope: @scopes,
      grant_type: "client_credentials"
    }, {
      "Content-Type" => "application/x-www-form-urlencoded"
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end
    @@token = data["access_token"]
    @@last_authenticated_at = Time.now
    return data["access_token"]
  end

  def auth_or_refresh_token
    if @@token.nil?
      authenticate()
      return
    end
    if diff_in_seconds(@@last_authenticated_at, Time.now) > fifty_minutes()
      authenticate()
      return
    end
  end

  def diff_in_seconds(from, to)
    (to - from).to_i
  end

  def fifty_minutes
    3000
  end

  def validate_date_range(from, to)
    validate_iso_date(from)
    validate_iso_date(to)
  end

  def validate_iso_date(value)
    iso8601_pattern = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\z/
    if value.match?(iso8601_pattern)
      return
    else
      raise ArgumentError, "Invalid date format. Must be ISO format: YYYY-MM-DDTHH:MM:SSZ."
    end
  end

end