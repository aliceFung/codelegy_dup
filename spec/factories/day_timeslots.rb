FactoryGirl.define do
  factory :day_timeslot do
    day_id 1
    timeslot_id 1

    factory :profile_timeslot do
      after(:build) do |day_timeslot|
        day_timeslot.owner = create(:profile)
      end
    end

    factory :project_timeslot do
      after(:build) do |day_timeslot|
        day_timeslot.owner = create(:project)
      end
    end
  end



end
