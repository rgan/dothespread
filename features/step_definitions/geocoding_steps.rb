When /^I geocode ([^,]*), ([^,]*), ([^,]*)$/ do |streetAddress, city, country|
  @location = Geocoder.geocode(streetAddress, city, country)
end

Then /^I should get latitude ([0-9.-]+) and longitude ([0-9.-]+)$/ do |lat, lng|
  @location.latitude.to_i.should == lat.to_i
  @location.longitude.to_i.should == lng.to_i
end