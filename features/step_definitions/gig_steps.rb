Given 'I have no gigs' do
  Gig.destroy_all
end

Given 'a gig exists' do
  @gig = FactoryGirl.create :gig
end

Given 'I have a gig' do
  @gig = FactoryGirl.create :gig, user: @current_user
end

Given /^I have the following gigs?:$/ do |table|
  table.hashes.each do |hash|
    @gig = FactoryGirl.create :gig, hash.transform_keys {|key| key.gsub %r{\s}, '_' }.merge(user: @current_user)
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

    selector = "//*[@class='gig']#{fields}"
    {
      'time-range' => time_range,
      'terms' => terms,
      'amount-due' => amount_due,
      'name' => name
    }.each do |class_name, text|
      selector << "[#{xpath class_name: class_name, text: text}]" if text.present?
    end

    sense = negation ? :not_to : :to
    expect(page).public_send sense, have_xpath(selector)
  end
end

Then /^the gig named "([^"]*)" should (not )?be flagged as overdue$/ do |name, negation|
  sense = negation ? :not_to : :to
  within *selector_for(%Q{terms for the gig named "#{name}"}) do
    expect(page).public_send sense, have_selector('.overdue', text: 'Overdue')
  end
end

private

def xpath(class_name:, text:)
  "//*[@class='#{class_name}'][contains(normalize-space(.), '#{text}')]"
end
