FactoryGirl.define do
  factory :user do

    sequence(:username) { |n| "foo#{n}" }
    sequence(:email) { |n| "foo#{n}@bar.com"}
    password '12345678'
    password_confirmation '12345678'
    provider 'Github'
    uid '1234'

  end

end
