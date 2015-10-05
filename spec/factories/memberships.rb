FactoryGirl.define do
  factory :membership do
    association :user
    association :project
    participant_type 'pending'
  end

end
