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
    | text            |
    | <gig>           |
    | <city>, <state> |
    | <start>         |
    | <end>           |
  # TODO: we shouldn't need that useless table header

  Examples:
    | gig               | city   | state | start             | end               |
    | Blackmore's Night | Moscow | ID    | 10 Oct 2003 19:00 | 10 Oct 2003 21:00 |
