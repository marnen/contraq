Given 'I have no gigs' do
  Gig.destroy_all
end

Then 'I should see a gig with name: "$name"' do |name|
  expect(page).to have_css '.gig', text: name
end
