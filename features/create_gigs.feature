Feature: Create gigs
As a user
I can create gigs
So I can see what I've committed to

Scenario Outline:
  Given I am logged in
  And I have no gigs
  And I am on the new gig page
  When I fill in the following:
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
