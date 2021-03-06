FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| "foo#{n}" }
    sequence(:email) {|n| "myemail@user#{n*1200}.com"}
    # sequence(:email) { |n| "foo#{n}@bar.com"}
    password '12345678'
    password_confirmation '12345678'
    provider 'Github'
    uid '1234'

    after(:build) { |user| user.confirm }
  end

end
