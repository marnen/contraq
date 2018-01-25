FactoryGirl.define do
  factory :payment do
    gig
    received_at { Faker::Date.backward 14 }
    amount { rand(1..10000) / 100.0 }
  end
end
