require 'net/https'
require 'uri'

class GoogleAnalytics

  def self.getFeed(token)
    url = 'https://www.google.com/analytics/feeds/data?ids=ga:51973535&dimensions=ga:city,ga:country,ga:latitude,ga:longitude&metrics=ga:pageviews&start-date=2008-10-01&end-date=2011-12-31&start-index=1&max-results=100&v=2&alt=json'
    uri = URI.parse(url)
    puts uri.request_uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https" # enable SSL/TLS
    http.start {

      http.request_get(uri.request_uri, {'Authorization' => "AuthSub token=#{token}"}) { |response|
        raise response.body unless response.code == "200"
        puts response.body
        parsed_json = ActiveSupport::JSON.decode(response.body)
        return parsed_json["feed"]["entry"].collect { |entry| PageView.from_json(entry) }
      }
    }
  end
end