FactoryGirl.define do
  factory :member_table do
    project
    user
    participant_type 'Owner'
  end
end
