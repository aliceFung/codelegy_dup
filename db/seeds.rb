User.destroy_all
Language.destroy_all
Difficulty.destroy_all
Project.destroy_all
Membership.destroy_all
ProfileLanguage.destroy_all
Email.destroy_all


Language.create(name: 'HTML', url: '/logos/html.png')
Language.create(name: 'Ruby', url: '/logos/ruby.jpg')
Language.create(name: 'Rails', url: '/logos/rails.png')
Language.create(name: 'JavaScript', url: '/logos/js.jpg')
Language.create(name: 'Node', url: '/logos/node.png')
Language.create(name: 'Python', url: '/logos/python.png')
Language.create(name: 'Swift', url: '/logos/swift.jpg')
Language.create(name: 'Java', url: '/logos/java.png')
Language.create(name: 'C', url: '/logos/c.png')
Language.create(name: 'PHP', url: '/logos/php.png')

Difficulty.create(name: 'Beginnger')
Difficulty.create(name: 'Intermediate')
Difficulty.create(name: 'Advanced')
Difficulty.create(name: 'Expert')

Project.create(title: 'my first project', difficulty_id: 2,
               availability: 'weekends')

ProjectLanguage.create(project_id: 1, language_id: 1)
ProjectLanguage.create(project_id: 1, language_id: 2)
ProjectLanguage.create(project_id: 1, language_id: 3)
ProjectLanguage.create(project_id: 1, language_id: 4)


4.times do |i|
  user = User.create(email: "foo#{i}@bar.com", password: '12345678')
  Membership.create(project_id: 1, user_id: user.id, participant_type: 'member')
end

Membership.first.update(participant_type: 'owner')
User.create(email: "test@bar.com", password: '12345678')
