class ViewsByLocation
  attr_reader :no_of_views, :latitude, :longitude

  def initialize(latitude, longitude, no_of_views)
     @latitude, @longitude, @no_of_views = latitude, longitude, no_of_views
  end

  def self.from_json(parsed_json)
    dimensions_array = parsed_json["dxp$dimension"]
    no_of_views = parsed_json["dxp$metric"][0]["value"]
    return ViewsByLocation.new(dimension_value("ga:latitude", dimensions_array), dimension_value("ga:longitude", dimensions_array), no_of_views)
  end

  private
  def self.dimension_value(name, dimensions)
    dimensions.find { |dim| name == dim["name"] }["value"]
  end
end