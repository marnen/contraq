Given 'the gig has a payment' do
  @payment = FactoryGirl.create :payment, gig: @gig
end

Given /^the gig has the following payments?:$/ do |table|
  table.hashes.each do |hash|
    @payment = FactoryGirl.create :payment, hash.merge(gig: @gig)
  end
end
