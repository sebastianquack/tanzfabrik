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

  def get_events(user_id, calendar_id)
    auth_or_refresh_token()
    url_stub = "#{@@ms_graph_url}/users/#{user_id}/calendars/#{calendar_id}/events"
    http_client = HttpClient.new()
    data = http_client.get(url_stub, {
      "Authorization" => "Bearer #{@@token}"
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end
    return data["value"]
  end

  def get_event(user_id, event_id)
    auth_or_refresh_token()
    url_stub = "#{@@ms_graph_url}/users/#{user_id}/events/#{event_id}"
    http_client = HttpClient.new()
    data = http_client.get(url_stub, {
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
    puts "authenticating with ms graph."
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

end

class HttpClient
  def get(url, headers = {}) 
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url)

    headers.each do |header_name, header_value|
      request[header_name] = header_value
    end

    response = http.request(request)

    if response.code.start_with? '20'
      return JSON.parse(response.body)
    else
      Rails.logger.debug "Failed to get data: #{response.code}, #{response.message}"
      return JSON.parse(response.body)
    end
  end

  def post(url, payload = {}, headers = {})
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    request = Net::HTTP::Post.new(uri)

    headers.each do |header_name, header_value|
      request[header_name] = header_value
    end

    body = build_body(headers, payload)
    request.body = body

    response = http.request(request)

    if response.code == '200'
      return JSON.parse(response.body)
    else
      Rails.logger.debug "Failed to post data: #{response.code}, #{response.message}"
      return JSON.parse(response.body)
    end
  end

  def build_body(headers, data)
    if(headers['Content-Type'] == 'application/x-www-form-urlencoded')
      return URI.encode_www_form(data)
    end
    if(headers['Content-Type'] == 'application/json')
      return data.to_json
    end
  end
end

