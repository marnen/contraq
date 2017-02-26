Given 'I have no gigs' do
  Gig.destroy_all
end

Given 'I have the following gigs:' do |table|
  table.hashes.each do |hash|
    FactoryGirl.create :gig, hash
  end
end

Then 'I should see a gig with name: "$name"' do |name|
  expect(page).to have_css '.gig', text: name
end

Then(/^I should see the following gigs:$/) do |table|
  table.hashes.each do |hash|
    fields = hash.values.map {|value| "[contains(., '#{value}')]" }.join
    expect(page).to have_xpath "//*[@class='gig']#{fields}"
  end
end
