Feature: View gigs
As a user
I can look at my gigs
So I can see more details about them than would fit in the list view

Scenario Outline: Link to gig detail from gig list
  Given I am logged in
  And I have the following gig:
    | name  | city   | start time | end time |
    | <gig> | <city> | <start>    | <end>    |
  And I am on the gigs page
  When I click "<gig>"
  Then I should be on the gig page for "<gig>"

  Examples:
    | gig            | city          | start             | end               |
    | Ig Nobel Awards | Cambridge, MA | 18 Sep 2090 20:30 | 18 Sep 2090 23:00 |
