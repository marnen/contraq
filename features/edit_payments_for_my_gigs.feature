Feature: Edit payments for my gigs
As a user
I can edit payments for my gigs
So I can correct mistakes

Background:
  Given I am logged in

Scenario Outline: Edit existing payments for my gigs from gig list or detail page
  Given I have a gig
  And the gig has the following payment:
    | amount       |
    | <old_amount> |
  And I am on the <page_to_test>
  When I click "Edit" within the payment
  Then I should be on the edit page for the payment
  When I fill in the following:
    | Amount | <new_amount> |
  And I click "Save payment"
  Then I should be on the <page_to_test>
  And I should not see "<old_amount>" within the gig's payments
  But I should see "<new_amount>" within the gig's payments

  Examples:
    | page_to_test | old_amount | new_amount |
    | gigs page    | 20.00      | 10.50      |
    | gig's page   | 20.00      | 30.00      |
