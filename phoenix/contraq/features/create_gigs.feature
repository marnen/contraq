Feature: Create gigs
As a user
I can create gigs
So I can record what I've committed to

Scenario: Link from gig list
  Given I am logged in
  And I am on the gigs page
  When I click "New gig"
  Then I should be on the new gig page
