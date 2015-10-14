FactoryGirl.define do
  factory :profile do
    about "MyString"
    user
    availability "Mon-Wed 8-10am"
    photo_id 1
    email_frequency nil
  end

end
