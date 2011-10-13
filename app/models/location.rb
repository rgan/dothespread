class Location
  attr_accessor :latitude, :longitude

  def initialize(lat, lng)
    @latitude = lat
    @longitude = lng
  end

  def self.from_json(json)
    parsed_json = ActiveSupport::JSON.decode(json)
    location = parsed_json["results"][0]["geometry"]["location"]
    return Location.new location["lat"].to_f, location["lng"].to_f
  end
end