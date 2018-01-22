FactoryGirl.define do
  factory :gig do
    user
    name { Faker::Lorem.sentence }
    start_time { Faker::Time.forward 100, :evening }
    end_time { start_time.to_datetime + 2.hours }
    venue { Faker::Company.name }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    amount_due { rand(50000) / 100.0 }
    terms { rand 120 }
  end
end
