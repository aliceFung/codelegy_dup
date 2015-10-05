FactoryGirl.define do
  factory :membership do
    participant_type "pending"
    association :user
    association :project
  end

end
