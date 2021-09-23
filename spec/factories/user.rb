FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    api_key { Faker::String.random(length: 12..18) }
  end
end
