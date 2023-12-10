
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

