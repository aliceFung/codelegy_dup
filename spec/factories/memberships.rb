FactoryGirl.define do
  factory :membership do
    association :user
    association :project

  end

end
