require 'net/http'
require 'uri'
require 'json'

class MsGraphClient
  attr_accessor :token

  def initialize(tenant_id, client_id, client_secret, scopes)
    @client_id = client_id
    @client_secret = client_secret
    @scopes = scopes
    @login_url = "https://login.microsoftonline.com"
    @ms_graph_url = "https://graph.microsoft.com/v1.0"
    @tenant_id = tenant_id
  end

  def authenticate
    http_client = HttpClient.new()
    data = http_client.post("#{@login_url}/#{@tenant_id}/oauth2/v2.0/token", {
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
    @token = data["access_token"]
    return data["access_token"]
  end


  def get_events(user_id, calendar_id)
    url_stub = "#{@ms_graph_url}/users/#{user_id}/calendars/#{calendar_id}/events"
    http_client = HttpClient.new()
    data = http_client.get(url_stub, {
      "Authorization" => "Bearer #{@token}"
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end
    return data["value"]
  end

  def get_calendars(user_id)
    url_stub = "#{@ms_graph_url}/users/#{user_id}/calendars"
    http_client = HttpClient.new()
    data = http_client.get(url_stub, {
      "Authorization" => "Bearer #{@token}"
    })
    if data.key?("error")
      return {error: data["error"]["code"], message: data["error_description"]}
    end
    return data["value"]
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

    if response.code == '200'
      return JSON.parse(response.body)
    else
      puts "Failed to fetch data: #{response.code} #{response.message}"
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
      puts "Failed to fetch data: #{response.code} #{response.message}"
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

