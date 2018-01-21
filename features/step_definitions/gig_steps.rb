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
  # TODO: use selectors helper
  expect(page).to have_css '.gig .name', text: name
end

Then /^I should (not )?see the following gigs?:$/ do |negation, table|
  table.hashes.each do |hash|
    # TODO: refactor this mess!

    name = hash.delete 'name'
    start_time = hash.delete 'start time'
    end_time = hash.delete 'end time'
    time_range = [start_time, end_time].compact.map {|time| Time.parse(time).strftime '%-d %b %Y %-l:%M %p' }.join '–'
    terms = "#{hash.delete 'terms'} (#{hash.delete 'due date'})" if hash['terms']
    amount_due = hash.delete 'amount due'
    fields = hash.values.map {|value| "[contains(normalize-space(.), '#{value}')]" }.join

    selector = "//*[@class='gig']#{fields}[//*[@class='time-range'][contains(normalize-space(.), '#{time_range}')]]"
    selector << "[//*[@class='terms'][contains(normalize-space(.), '#{terms}')]]" if terms.present?
    selector << "[//*[@class='amount-due'][contains(normalize-space(.), '#{amount_due}')]]" if amount_due.present?
    selector << "[//*[@class='name'][contains(normalize-space(.), '#{name}')]]" if name.present?

    sense = negation ? :not_to : :to
    expect(page).public_send sense, have_xpath(selector)
  end
end
