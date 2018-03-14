Feature: Show payment terms for gig
As a user
I can see payment terms for each gig
So I can tell what I am owed and when

Background:
  Given I am logged in

Scenario Outline: Show terms on gig detail page
  Given I have the following gig:
    | name   | start time | amount due | terms   |
    | <name> | <start>    | <amount>   | <terms> |
  When I go to the gig page for "<name>"
  Then I should see "Amount due: <amount>"
  And I should see "Terms: <terms> (<due_date>)"

  Examples:
    | name     | start            | amount | terms   | due_date    |
    | Paid Gig | 1 Feb 2050 20:00 | 150.00 | 10 days | 11 Feb 2050 |

# Scenario Outline: Show terms on gig list
#   Given I have the following gig:
#     | name   | start time | amount due | terms   |
#     | <name> | <start>    | <amount>   | <terms> |
#   When I go to the gigs page
#   Then I should see the following gig:
#     | name   | start time | amount due | terms   | due date   |
#     | <name> | <start>    | <amount>   | <terms> | <due_date> |
#
#   Examples:
#     | name            | start            | amount | terms   | due_date    |
#     | Better Paid Gig | 2 Feb 2050 20:00 | 225.25 | 12 days | 14 Feb 2050 |
