Given 'I am on $page_name' do |page_name|
  visit path_to page_name
end

When 'I click "$text"' do |text|
  click_on text
end

When 'I fill in the following:' do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

When 'I go to $page_name' do |page_name|
  visit path_to page_name
end

Then 'I should not be able to get to $page_name' do |page_name|
  path = path_to page_name
  visit path
  expect(current_path).not_to be == path
end

Then /^I should (not )?be on (.+)$/ do |negation, page_name|
  expect(current_path == path_to(page_name)).to be == !negation
end

Then(/^I should (not )?see "([^"]*)"$/) do |negation, text|
  expect(page.has_text? text).to be == !negation
end
