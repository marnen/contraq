Given 'I have no gigs' do
  Gig.destroy_all
end

Given 'a gig exists' do
  @gig = FactoryGirl.create :gig
end

Given /^I have the following gigs?:$/ do |table|
  table.hashes.each do |hash|
    FactoryGirl.create :gig, hash.transform_keys {|key| key.gsub %r{\s}, '_' }.merge(user: @current_user)
  end
end

Given 'the following gigs exist:' do |table|
  table.hashes.each do |hash|
    hash['user'] = User.find_by email: hash.delete('user')
    FactoryGirl.create :gig, hash
  end
end

Then 'I should see a gig with name: "$name"' do |name|
  expect(page).to have_css '.gig', text: name
end

Then /^I should (not )?see the following gigs?:$/ do |negation, table|
  table.hashes.each do |hash|
    fields = hash.values.map {|value| "[contains(., '#{value}')]" }.join
    xpath_state = ['has', (negation && 'no'), 'xpath?'].compact.join '_'
    expect(page.send xpath_state, "//*[@class='gig']#{fields}").to be true
  end
end
