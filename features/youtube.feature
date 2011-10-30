Feature: Youtube
  Scenario: Should post video metadata to youtube
    Given I have an invalid authsub token and key
    When I post video title "title" and keywords "keywords"
    Then I should not get back a valid response from youtube