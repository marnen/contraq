Feature: Show payment terms for gig
As a user
I can see payment terms for each gig
So I can tell what I am owed and when

Scenario Outline: Show terms on gig detail page
  Given I am logged in
  And I have the following gig:
    | name   | start time | amount due | terms   |
    | <name> | <start>    | <amount>   | <terms> |
  When I go to the gig page for "<name>"
  Then I should see "Amount due: <amount>"
  And I should see "Terms: <terms> (<due_date>)"

  Examples:
    | name     | start              | amount | terms   | due_date    |
    | Paid Gig | 1 Feb 2050 8:00 PM | 150.00 | 10 days | 11 Feb 2050 |
