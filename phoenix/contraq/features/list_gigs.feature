Feature: List gigs
As a user
I can list my gigs
So I can see what I've already committed to

Scenario Outline: List my own gigs
  Given I am logged in
  And I have the following gigs:
    | name   | city    | start time | end time |
    | <gig1> | <city1> | <start1>   | <end1>   |
    | <gig2> | <city2> | <start2>   | <end2>   |
  When I go to the gigs page
  Then I should see the following gigs:
    | name   | city    | start time | end time |
    | <gig1> | <city1> | <start1>   | <end1>   |
    | <gig2> | <city2> | <start2>   | <end2>   |

  Examples:
    | gig1       | city1  | start1           | end1             | gig2           | city2  | start2           | end2             |
    | My Recital | Gotham | 2 Jan 2100 20:00 | 2 Jan 2100 22:00 | Kangaroo Music | Sydney | 1 Feb 2100 12:00 | 1 Feb 2100 15:00 |

Scenario Outline: Can't see others' gigs
  Given the following users exist:
    | email        | password   |
    | <me>         | <password> |
    | <other_user> | <password> |
  And the following gigs exist:
    | name        | user         |
    | <my_gig>    | <me>         |
    | <other_gig> | <other_user> |
  And I am logged in with e-mail "<me>" and password "<password>"
  When I go to the gigs page
  Then I should see "<my_gig>"
  But I should not see "<other_gig>"

  Examples:
    | me         | password | other_user    | my_gig | other_gig      |
    | me@aol.com | p@ssw0rd | other@user.in | My Gig | Some Other Gig |
