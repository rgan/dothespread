require 'net/http'
require 'uri'

class GoogleAnalytics

  def self.getFeed(id, email, pwd)
    token = getToken(email, pwd)
    url = "https://www.google.com/analytics/feeds/data?ids=ga:#{id}&dimensions=ga:city,ga:country,ga:latitude,ga:longitude&metrics=ga:pageviews&start-date=2008-10-01&end-date=2011-12-31&start-index=1&max-results=100&v=2&alt=json"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https" # enable SSL/TLS
    http.start {

      http.request_get(uri.request_uri, {'Authorization' => "GoogleLogin auth=#{token}", 'GData-Version' => '2'}) { |response|
        raise response.body unless response.code == "200"
        puts response.body
        parsed_json = ActiveSupport::JSON.decode(response.body)
        return parsed_json["feed"]["entry"].collect { |entry| ViewsByLocation.from_json(entry) }
      }
    }
  end

  def self.getToken(email, pwd)
    uri= URI.parse('https://www.google.com/accounts/ClientLogin')
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data({'Email' => "#{email}",
                    'Passwd' => "#{pwd}",
                    'accountType' => "Google",
                    'service' => 'analytics'
    })
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https" # enable SSL/TLS
    http.start {
      response = http.request(request)
      raise response.body unless response.code == "200"
      return /Auth=(.*)/.match(response.body) ? /Auth=(.*)/.match(response.body)[1] : nil
    }
  end

end