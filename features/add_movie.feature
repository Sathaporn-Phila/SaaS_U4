Feature: User can manually add movie

@user_test
Scenario: Add a movie (sad path)
  Given I am on the home page
  When I go to "Log in with your Facebook account"
  Then I should see "Add new movie"
  When I go to "Add new movie"
  Then I should see "Create New Movie"