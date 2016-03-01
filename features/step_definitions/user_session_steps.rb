Given 'I am not logged in' do
  # no-op at the moment
end

When /^I log in with e-?mail "(.*?)" and password "(.*?)"$/ do |email, password|
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_on 'Log in'
end

Then 'I should be logged in as "$email"' do |email|
  expect(page).to have_text "Logged in as #{email}"
end
