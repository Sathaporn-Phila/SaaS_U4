Feature: User can login 

    @user_test
    Scenario: Login pass
    Given I am on the home page
    When I go to "Log in with your Facebook account"
    Then I am on the home page
    And I should see "log out"

