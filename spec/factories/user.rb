FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    api_key { 'alsjdf09sadfkjashdf0ysd09832jb' }
  end
end
