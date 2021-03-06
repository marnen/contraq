Feature: Add payments for my gigs
As a user
I can report payments for my gigs
So that I can keep track of what I'm still owed

Background:
  Given I am logged in

Scenario Outline: Add payments from gig list or detail page
  # TODO: should we break up this scenario?
  Given today is <today>
  And I have the following gig:
    | name   | amount due   |
    | <name> | <amount_due> |
  And I am on the <page_to_test>
  When I click "Report payment" within the gig
  Then I should be on the new payment page for the gig
  And I should see the value "<today>" in the "Date received" field
  When I fill in the following:
    | Date received | <date>            |
    | Amount        | <amount_received> |
  And I click "Save payment"
  Then I should be on the <page_to_test>
  And I should see "<date>: <amount_received>" within the gig's payments

  Examples:
    | page_to_test | today      | name         | amount_due | date        | amount_received |
    | gigs page    | 2050-02-15 | Not Paid Yet | 150        | 14 Feb 2050 | 10.50           |
    | gig's page   | 2050-03-15 | Detail Page  | 200        | 14 Mar 2050 | 20.00           |

Scenario: Can't add payments to others' gigs
  Given a gig exists
  Then I should not be able to get to the new payment page for the gig
