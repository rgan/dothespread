Feature: Geocode
  Scenario: Should post video metadata to youtube
    Given I have an invalid authsub token and key
    When I post video title "test"
    Then I should not get back a valid response from youtube