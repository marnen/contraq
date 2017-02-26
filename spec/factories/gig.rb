FactoryGirl.define do
  factory :gig do
    name { Faker::Lorem.sentence }
    start_time { Faker::Time.forward 100, :evening }
    end_time { start_time + 2.hours }
    venue { Faker::Company.name }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end
end
