FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "myemail@user#{n}.com"}
  end

end
