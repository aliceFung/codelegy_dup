FactoryGirl.define do
  factory :membership do
    association :user
    association :project
    type "pending"
  end

end
