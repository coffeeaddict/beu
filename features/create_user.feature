Feature: Create user
  In order to display my dismay
  As an anonymous internet lurker
  I want to become a user

  Scenario: Create user
    Given I am an anonymous lurker
    When I create a user
    Then I have a user