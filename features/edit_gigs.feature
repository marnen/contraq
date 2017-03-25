Feature: Edit gigs
As a user
I can edit gigs
So I can keep my information current

Scenario Outline: Basic gig editing
  Given I am logged in
  And I have the following gig:
   | name       | start time  | end time  | city       | state       |
   | <old_name> | <old_start> | <old_end> | <old_city> | <old_state> |
  And I am on the gigs page
  When I click "edit"
  And I fill in the following:
    | Name       | <new_name>   |
    | Start time | <new_start>  |
    | End time   | <new_end>    |
    | Street     | <new_street> |
    | City       | <new_city>   |
    | State      | <new_state>  |
    | Zip        | <new_zip>    |
  And I click "Save"
  Then I should be on the gigs page
  And I should see the following gig:
    | name       | start time  | end time  | city       | state       |
    | <new_name> | <new_start> | <new_end> | <new_city> | <new_state> |
  But I should not see the following gig:
    | name       | start time  | end time  | city       | state       |
    | <old_name> | <old_start> | <old_end> | <old_city> | <old_state> |


  Examples:
    | old_name | new_name | old_start        | old_end          | new_start        | new_end          | old_street         | new_street      | old_city | old_state | new_city   | new_state |
    | My Gig   | Tunez!   | 2100-12-25 20:00 | 2100-12-25 22:30 | 2100-01-01 08:00 | 2100-01-02 01:00 | 881 Seventh Avenue | 123 Main Street | New York | NY        | Charleston | SC        |

Scenario: Can't edit gigs unless logged in
  Given I am not logged in
  And a gig exists
  Then I should not be able to get to the edit page for the gig
