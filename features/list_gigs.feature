Feature: List gigs
As a user
I can list my gigs
So I can see what I've already committed to

Scenario Outline:
  Given I am logged in
  And I have the following gigs:
    | name   | city    |
    | <gig1> | <city1> |
    | <gig2> | <city2> |
  When I go to the gigs page
  Then I should see the following gigs:
    | name   | city    |
    | <gig1> | <city1> |
    | <gig2> | <city2> |

  Examples:
    | gig1       | city1  | gig2           | city2  |
    | My Recital | Gotham | Kangaroo Music | Sydney |
