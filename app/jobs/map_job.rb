require 'google_analytics'

class MapJob

  def perform
    locations = GoogleAnalytics.getFeed('51973535', ENV["ANALYTICS_USER"], ENV["ANALYTICS_PWD"])
    getMap(locations)
  end

  def getMap(locations)
    map_url = "http://maps.googleapis.com/maps/api/staticmap?zoom=1&size=575x286&maptype=roadmap&markers=color:blue&sensor=false"
    markers = locations.collect { |location| location.latitude + "," + location.longitude}.join("|")
    map_url = map_url + "&markers=" + URI.escape(markers)
    uri = URI.parse(map_url)
    http = Net::HTTP.new(uri.host, uri.port)
    begin
      f = open('public/map_new_tmp.png', 'wb')
      http.request_get(uri.request_uri) do |resp|
        resp.read_body do |segment|
          f.write(segment)
        end
      end
    ensure
      f.close()
    end
    FileUtils.cp('public/map_new_tmp.png', 'public/map_new.png')
  end
end