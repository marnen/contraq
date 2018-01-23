Feature: Add payments for gigs that haven't been paid in full
As a user
I can report payments for gigs not yet paid in full
So that I can keep track of what I'm still owed

Scenario Outline: Add payments from gig list
  # TODO: should we break up this scenario?
  Given today is <today>
  And I am logged in
  And I have the following gig:
    | name   | amount due   |
    | <name> | <amount_due> |
  And I am on the gigs page
  When I click "Report payment" within the gig
  Then I should be on the new payment page for the gig
  And I should see the value "<today>" in the "Date received" field
  When I fill in the following:
    | Date received | <date>            |
    | Amount        | <amount_received> |
  And I click "Save payment"
  Then I should be on the gigs page
  And I should see "<date>: <amount_received>" within the gig's payments

  Examples:
    | today      | name         | amount_due | date        | amount_received |
    | 2050-02-15 | Not Paid Yet | 150        | 14 Feb 2050 | 10.50           |
