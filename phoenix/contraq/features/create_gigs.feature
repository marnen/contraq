Feature: Create gigs
As a user
I can create gigs
So I can record what I've committed to

Scenario: Link from gig list
  Given I am logged in
  And I am on the gigs page
  When I click "New gig"
  Then I should be on the new gig page

Scenario Outline: Basic gig creation
  Given I am logged in
  And I have no gigs
  And I am on the new gig page
  When I fill in the following:
    | field      | value    |
    | Name       | <name>   |
    | Start time | <start>  |
    | End time   | <end>    |
    | Venue      | <venue>  |
    | Street     | <street> |
    | City       | <city>   |
    | State      | <state>  |
    | Zip        | <zip>    |
  And I click "Save"
  Then I should be on the gigs page
  And I should see a gig with name: "<name>"

  Examples:
    | name   | start            | end              | venue         | street             | city     | state | zip   |
    | My Gig | 2100-12-25 20:00 | 2100-12-25 22:30 | Carnegie Hall | 881 Seventh Avenue | New York | NY    | 10019 |

Scenario: Can't create gigs unless logged in
  Given I am not logged in
  When I go to the new gig page
  Then I should not be on the new gig page
