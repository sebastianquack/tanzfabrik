require 'net/http'
require 'uri'
require 'json'

class MsGraphClient
  attr_accessor :auth_token


  def initialize(client_id, client_secret, scope)
    @client_id = client_id
    @client_secret = client_secret
    @scope = scope
    @login_url = "https://login.microsoftonline.com"
    @ms_graph_url = "https://graph.microsoft.com/v1.0"
    @account_id = "2b07e5c4-cf90-4914-b15c-d83a785b1e5a"
  end

  def authenticate
    http_client = HttpClient.new()
    data = http_client.post("#{@login_url}/#{@account_id}/oauth2/v2.0/token", {
      client_id: @client_id,
      client_secret: @client_secret,
      scope: @scope,
      grant_type: "client_credentials"
    }, {
      "Content-Type" => "application/x-www-form-urlencoded"
    })

    return data
  end

end

class HttpClient
  def get(url, headers = {}) 
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url)

    response = http.request(request)

    if response.code == '200'
      return JSON.parse(response.body)
    else
      return response
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
    puts headers['Content-Type']
    if(headers['Content-Type'] == 'application/x-www-form-urlencoded')
      form_data = URI.encode_www_form(data)
      puts form_data 
      return form_data
    end
    if(headers['Content-Type'] == 'application/json')
      return data.to_json
    end
  end


end


# require 'microsoft_graph'


# desc 'test ms_graph client'
# task :test_ms_graph_client => :environment do

#   puts "Hello world!"

#   # Replace these variables with your actual values
#   client_id = '7c7608bf-a091-4e6c-a5c1-301232ac6cb1'
#   client_secret = '6nK8Q~9s22oDM3gh3.2C9O3PDTVqotYM5F76wb~-'
#   scopes = ['https://graph.microsoft.com/.default'] # Add any required scopes

#   # Initialize the client
#   client = MicrosoftGraph::Client.new(
#     client_id: client_id,
#     client_secret: client_secret,
#     scopes: scopes,
#   )

#   # Authenticate and obtain an access token
#   client.authenticate!

#   # Make an example request (e.g., list user's events)
#   events = client.me.events.get

#   # Print the response
#   puts 'Events:'
#   events.each do |event|
#     puts "Subject: #{event.subject}"
#   end
# end


