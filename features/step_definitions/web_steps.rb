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

Then 'I should be on $page_name' do |page_name|
  expect(current_path).to be == path_to(page_name)
end
