Given /^the gig has the following payments?:$/ do |table|
  table.hashes.each do |hash|
    @payment = FactoryGirl.create :payment, hash.merge(gig: @gig)
  end
end
