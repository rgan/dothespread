require 'google_analytics'

class MapJob

  def perform
    locations = GoogleAnalytics.getFeed('51973535', ENV["ANALYTICS_USER"], ENV["ANALYTICS_PWD"])
    getMap(locations)
  end

  def getMap(locations)
    map_url = "http://maps.googleapis.com/maps/api/staticmap?center=45,5&zoom=1&format=png&sensor=false&size=500x350&maptype=roadmap&style=feature:water|visibility:on|hue:0xff1100|lightness:100&style=feature:administrative|hue:0x0000ff|visibility:off&style=feature:water|element:labels|visibility:off&style=feature:poi|visibility:off&style=feature:landscape|element:geometry|visibility:on|hue:0x00ff19|lightness:-55"
    markers = locations.collect { |location| location.latitude + "," + location.longitude}.join("|")
    map_url = map_url + "&markers=size:tiny%7Ccolor:red%7C" + URI.escape(markers)
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