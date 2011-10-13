Feature: Geocode
  Scenario: Should geocode address
    When I geocode 1600 Amphitheatre Parkway, Mountain View, CA
    Then I should get latitude 37 and longitude -122