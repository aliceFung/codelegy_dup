FactoryGirl.define do
  factory :membership do
    association :user
    association :project
    participant_type 'owner'
  end

end
