require 'google_analytics'
require 'aws/s3'

class MapJob
  MAX_ELEMENTS= 83
  DIFF = 0.5

  def perform
    locations = GoogleAnalytics.getFeed('51973535', ENV["ANALYTICS_USER"], ENV["ANALYTICS_PWD"])
    puts "Total locations:#{locations.size}"
    locations = locations.select { |location| !(location.latitude.round() == 0 && location.longitude.round() == 0)}
    sorted_locations = locations.sort { |l1,l2| l2.latitude.to_f <=> l1.latitude.to_f}
    #sorted_locations.each_with_index { |l, i| puts l.latitude.to_s + "," + l.longitude.to_s}
    puts "Total locations after removing zeros:#{sorted_locations.size}"
    filtered_locations = []
    filtered_locations << sorted_locations[0]
    sorted_locations.each_cons(2) { |elements| filtered_locations << elements[1] if !elements[0].similar_location(elements[1], DIFF) }
    puts "After removing locations that are close to each other (#{DIFF}): #{filtered_locations.size}"
    getMap(filtered_locations.take(MAX_ELEMENTS))
  end

  def getMap(locations)
    map_url = "http://maps.googleapis.com/maps/api/staticmap?zoom=1&format=png&sensor=false&size=500x350&maptype=roadmap&center=45,5"
    markers = locations.collect { |location| location.latitude.to_s + "," + location.longitude.to_s}.join("|")
    map_url = map_url + "&markers=size:tiny%7Ccolor:red%7C" + URI.escape(markers)
    map_url = map_url + ["feature:water|visibility:on|hue:0xff1100|lightness:100",
                    "feature:administrative|hue:0x0000ff|visibility:off",
                    "feature:water|element:labels|visibility:off",
                    "feature:poi|visibility:off",
                    "feature:landscape|element:geometry|visibility:on|hue:0x00ff19|lightness:-55"].inject("") {|memo, f| memo + "&style=" + URI.escape(f)}
    puts map_url
    begin
      AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_KEY']
      )
      AWS::S3::S3Object.store('map.png',open(map_url), ENV['AWS_BUCKET'])
    rescue
      puts "Error saving to Amazon S3"
    end
    begin
      write_to_file(map_url)
    rescue
      puts "Error writing to file"
    end
  end

  def write_to_file(map_url)
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
      f.close() if f
    end
    FileUtils.cp('public/map_new_tmp.png', 'public/map_new.png')
  end
end