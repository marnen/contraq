Feature: Add payments for gigs that haven't been paid in full
As a user
I can report payments for gigs not yet paid in full
So that I can keep track of what I'm still owed

Scenario Outline: Add payments from gig list
  Given I am logged in
  And I have the following gig:
    | name   | amount due   |
    | <name> | <amount_due> |
  And I am on the gigs page
  When I click "Report payment" within the gig
  Then I should be on the new payment page for the gig

  Examples:
    | name         | amount_due |
    | Not Paid Yet | 150        |
