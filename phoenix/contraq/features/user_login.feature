Feature: User login
As a user
I can log into Contraq
So I can associate myself with my data

Scenario Outline: Valid login
  Given I am not logged in
  And the following user exists:
   | email   | password   |
   | <email> | <password> |
  When I go to the login page
  And I log in with e-mail "<email>" and password "<password>"
  Then I should be logged in as "<email>"

  Examples:
    | email           | password |
    | joe@example.com | påssw0rd |

Scenario: Invalid login
  Given I am not logged in
  When I go to the login page
  And I log in with e-mail "invalid@email" and password "oops"
  Then I should not be logged in

Scenario: Logout
  Given I am logged in with e-mail "someone@aol.com" and password "t0ps3kr1t"
  When I log out
  Then I should not be logged in
