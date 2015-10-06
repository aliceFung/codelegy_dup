User.destroy_all
Language.destroy_all
Difficulty.destroy_all
Project.destroy_all
Membership.destroy_all

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

Project.create(title: 'my first project', difficulty_id: 2,
               availability: 'weekends')

4.times do |i|
  user = User.create(email: "foo#{i}@bar.com", password: '12345678')
  Membership.create(project_id: 1, user_id: user.id, participant_type: 'member')
end

Membership.first.update(participant_type: 'owner')
