FactoryGirl.define do

  factory :email_digest do
    association :user
    days_delayed 1
  end

end
