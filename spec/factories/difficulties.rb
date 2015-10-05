FactoryGirl.define do
  factory :beginner, class: Difficulty do
    name 'Beginner'
  end

  factory :medium, class: Difficulty do
    name 'Medium'
  end

  factory :expert, class: Difficulty do
    name 'Expert'
  end

  factory :master, class: Difficulty do
    name 'Master'
  end
end
