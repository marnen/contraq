Given /^I am logged in(?: with e-?mail "(.*?)" and password "(.*?)")?$/ do |email, password|
  @current_user = User.find_by(email: email) if email
  @current_user ||= FactoryGirl.create :user, {email: email, password: password}.compact
  email ||= @current_user.email
  password ||= @current_user.password
  visit new_user_session_path
  login_as email: email, password: password
end

Given 'I am not logged in' do
  # no-op at the moment
end

When /^I log in with e-?mail "(.*?)" and password "(.*?)"$/ do |email, password|
  @current_user = User.find_by email: email
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
