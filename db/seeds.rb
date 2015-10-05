# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Language.create(name: 'Ruby/Rails')
Language.create(name: 'JavaScript')
Language.create(name: 'Python')
Language.create(name: 'C')
Language.create(name: 'Swift')
Language.create(name: 'Java')
Language.create(name: 'PHP')

Difficulty.create(name: 'Beginnger')
Difficulty.create(name: 'Intermediate')
Difficulty.create(name: 'Expert')
Difficulty.create(name: 'Master')

Project.create(title: "my first project", difficulty_id: 2,
              availability: "weekends")

User.create(email: "abc@123.com")

Membership.create(project_id: 1, user_id: 1, participant_type: "owner")