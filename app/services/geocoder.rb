require 'net/http'
require 'uri'

class Geocoder
  def self.geocode(streetAddress, city, country)
    address = streetAddress.gsub(/\s+/, '+') + "," + city.gsub(/\s+/, '+') + "," + country.gsub(/\s+/, '+')
    url = URI.parse('http://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&sensor=false')
    response = Net::HTTP.get_response(url)
    raise response.body unless response.code == "200"
    return Location.from_json(response.body)
  end
end