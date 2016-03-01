Given 'the following user exists:' do |table|
  User.create table.hashes.first
end
