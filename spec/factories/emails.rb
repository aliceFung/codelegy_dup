FactoryGirl.define do
  factory :email do
    association :user
    association :project
    content "Abc123"
    to_everyone false
  end
end
