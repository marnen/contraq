Feature: Flag overdue payments
As a user
I can see indications of overdue payments
So I can properly track and collect what's owed to me

Background:
  Given I am logged in

Scenario: Flag overdue payments on gig list
  Given I have the following gigs:
    | name        | start time | terms  |
    | Overdue     | 1 Jan 2018 | 1 day  |
    | Not Overdue | 1 Jan 2018 | 2 days |
  And today is 3 Jan 2018
  And I am on the gigs page
  Then the gig named "Overdue" should be flagged as overdue
  But the gig named "Not Overdue" should not be flagged as overdue
