FactoryGirl.define do
  factory :user, class: 'Ganttin::User' do
    name { Faker::Name.name }
    username { Faker::Internet.user_name }
    #email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
  end
end
