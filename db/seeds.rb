# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Language.destroy_all
Difficulty.destroy_all
Project.destroy_all
Membership.destroy_all
ProfileLanguage.destroy_all

Language.create(name: 'Ruby/Rails')
Language.create(name: 'JavaScript')
Language.create(name: 'Python')
Language.create(name: 'C')
Language.create(name: 'Swift')
Language.create(name: 'Java')
Language.create(name: 'PHP')

Difficulty.create(name: 'Beginnger')
Difficulty.create(name: 'Intermediate')
Difficulty.create(name: 'Advanced')
Difficulty.create(name: 'Expert')

Project.create(title: "my first project", difficulty_id: 2,
              availibility: "weekends")

4.times do |i|
  user = User.create(email: "foo#{i}@bar.com", password:"12345678")
  Membership.create(project_id: 1, user_id: user.id, participant_type: "member")
end

Membership.first.update(participant_type: "owner")

