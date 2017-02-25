Given /^I am logged in(?: with e-?mail "(.*?)" and password "(.*?)")?$/ do |email, password|
  user = FactoryGirl.create :user, {email: email, password: password}.compact
  visit new_user_session_path
  login_as email: user.email, password: user.password
end

Given 'I am not logged in' do
  # no-op at the moment
end

When /^I log in with e-?mail "(.*?)" and password "(.*?)"$/ do |email, password|
  login_as email: email, password: password
end

When 'I log out' do
  logout
end

Then 'I should be logged in as "$email"' do |email|
  expect(page).to have_text "Logged in as #{email}"
end

Then 'I should not be logged in' do
  expect(page).not_to have_text 'Logged in as'
end
