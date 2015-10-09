User.destroy_all
# Language.destroy_all
# Difficulty.destroy_all
Project.destroy_all
Membership.destroy_all
ProfileLanguage.destroy_all
ProjectLanguage.destroy_all
# Email.destroy_all

beginner = Difficulty.find_or_create_by(name: 'Beginner')
intermediate = Difficulty.find_or_create_by(name: 'Intermediate')
advanced = Difficulty.find_or_create_by(name: 'Advanced')
expert = Difficulty.find_or_create_by(name: 'Expert')

html = Language.find_or_create_by(name: 'HTML', url: '/logos/html.png')
  html.suggestions.create(title: "Learn to Code HTML & CSS", difficulty_id: beginner.id, url: 'http://learn.shayhowe.com/html-css/' )
  html.suggestions.create(title: "Learn to Code Advanced HTML & CSS", difficulty_id: advanced.id, url: 'http://learn.shayhowe.com/advanced-html-css/' )

ruby =Language.find_or_create_by(name: 'Ruby', url: '/logos/ruby.jpg')
  ruby.suggestions.create(title: "Ruby Primer", difficulty_id: beginner.id, url: 'https://rubymonk.com/learning/books/1-ruby-primer')
  ruby.suggestions.create(title: "Ruby Primer Ascent", difficulty_id: intermediate.id, url: 'https://rubymonk.com/learning/books/4-ruby-primer')
  ruby.suggestions.create(title: "Learn Ruby The Hard Way", difficulty_id: beginner.id, url: 'http://learnrubythehardway.org/')

rails = Language.find_or_create_by(name: 'Rails', url: '/logos/rails.png')
  rails.suggestions.create(title: 'Blogger 2', difficulty_id: intermediate.id, url: 'http://tutorials.jumpstartlab.com/projects/blogger.html')
  rails.suggestions.create(title: 'Ruby on Rails Tutorial', difficulty_id: intermediate.id, url: 'https://www.railstutorial.org/book')

js = Language.find_or_create_by(name: 'JavaScript', url: '/logos/js.jpg')
  js.suggestions.create(title: 'Javascripting', difficulty_id: beginner.id, url: 'https://github.com/sethvincent/javascripting#javascripting')

node = Language.find_or_create_by(name: 'Node', url: '/logos/node.png')
  node.suggestions.create(title: 'learnyounode', difficulty_id: beginner.id, url: 'https://github.com/workshopper/learnyounode#learn-you-the-nodejs-for-much-win')
  node.suggestions.create(title: 'ExpressWorks', difficulty_id: intermediate.id, url: 'https://github.com/azat-co/expressworks#expressworks')
  node.suggestions.create(title: 'Nodeschool', difficulty_id: beginner.id, url: 'http://nodeschool.io/#workshopper-list')

py = Language.find_or_create_by(name: 'Python', url: '/logos/python.png')
  py.suggestions.create(title: 'Learn Python the Hard Way', difficulty_id: beginner.id, url: 'http://learnpythonthehardway.org/book/')

Language.find_or_create_by(name: 'Swift', url: '/logos/swift.jpg')

Language.find_or_create_by(name: 'Java', url: '/logos/java.png')

Language.find_or_create_by(name: 'C', url: '/logos/c.png')

Language.find_or_create_by(name: 'PHP', url: '/logos/php.png')


a = Project.create(title: 'my first project', difficulty_id: 2,
               availability: 'weekends')
b = Project.create(title: 'another project', difficulty_id: 3,
               availability: 'weeknights')
c = Project.create(title: 'something', difficulty_id: 4,
                              availability: 'mon-fri')


ProjectLanguage.create(project_id: a.id, language_id: 1)
ProjectLanguage.create(project_id: a.id, language_id: 2)
ProjectLanguage.create(project_id: a.id, language_id: 3)
ProjectLanguage.create(project_id: a.id, language_id: 4)

ProjectLanguage.create(project_id: b.id, language_id: 4)
ProjectLanguage.create(project_id: b.id, language_id: 5)

ProjectLanguage.create(project_id: c.id, language_id: 6)
ProjectLanguage.create(project_id: c.id, language_id: 10)



4.times do |i|
  user = User.create(email: "foo#{i}@bar.com", password: '12345678')
  Membership.create(project_id: a.id, user_id: user.id, participant_type: 'member')
end

user1 = User.create(email: "test@bar.com", password: '12345678')
Membership.create(project_id: Project.first.id, user_id: user1.id, participant_type: 'owner')
Membership.create(project_id: Project.second.id, user_id: user1.id, participant_type: 'member')
Membership.create(project_id: Project.last.id, user_id: user1.id)

User.second.send_message(User.first, "test", "testingabc1")
User.first.send_message(User.last, '1 to 5', 'subject here')

# Membership.first.update(participant_type: 'owner')
