Feature: View gigs
As a user
I can look at my gigs
So I can see more details about them than would fit in the list view

Background:
  Given I am logged in

Scenario Outline: Link to gig detail from gig list
  Given I have the following gig:
    | name  | city   | state   |
    | <gig> | <city> | <state> |
  And I am on the gigs page
  When I click "<gig>"
  Then I should be on the gig page for "<gig>"

  Examples:
    | gig             | city      | state |
    | Ig Nobel Awards | Cambridge | MA    |

Scenario: Can't see others' gigs
  Given a gig exists
  Then I should not be able to get to the gig's page

Scenario Outline: Gig detail page
  Given I have the following gig:
    | name  | city   | state   | start time | end time |
    | <gig> | <city> | <state> | <start>    | <end>    |
  And I am on the gig page for "<gig>"
  Then I should see the following:
    | <gig>           |
    | <city>, <state> |
    | <start>         |
    | <end>           |

  Examples:
    | gig               | city   | state | start             | end               |
    | Blackmore's Night | Moscow | ID    | 10 Oct 2003 7:00 PM | 10 Oct 2003 9:00 PM |
