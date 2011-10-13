class Registration < ActiveRecord::Base

  before_save :geocode

  def geocode
    location = Geocoder.geocode(self.streetAddress, self.city, self.country)
    self.latitude = location.latitude
    self.longitude = location.longitude
  end
end