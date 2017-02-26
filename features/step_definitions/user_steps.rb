Given /^the following users? exists?:$/ do |table|
  table.hashes.each {|hash| FactoryGirl.create :user, hash }
end
