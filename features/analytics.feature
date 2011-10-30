Feature: Analytics
  Scenario: Should get map locations from analytics feed
    When I invoke the analytics feed
    Then I should get back locations