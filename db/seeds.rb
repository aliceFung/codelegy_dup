User.destroy_all
# Language.destroy_all
# Difficulty.destroy_all
Project.destroy_all
Membership.destroy_all
ProfileLanguage.destroy_all
ProjectLanguage.destroy_all

beginner = Difficulty.find_or_create_by(name: 'Beginner')
intermediate = Difficulty.find_or_create_by(name: 'Intermediate')
advanced = Difficulty.find_or_create_by(name: 'Advanced')
expert = Difficulty.find_or_create_by(name: 'Expert')

html = Language.find_or_create_by(name: 'HTML', url: '/logos/html.png')
  html.suggestions.create(title: "Learn to Code HTML & CSS", difficulty_id: beginner.id, url: 'http://learn.shayhowe.com/html-css/' )
  html.suggestions.create(title: "Learn to Code Advanced HTML & CSS", difficulty_id: advanced.id, url: 'http://learn.shayhowe.com/advanced-html-css/' )

ruby = Language.find_or_create_by(name: 'Ruby', url: '/logos/ruby.jpg')
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

days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
days.each do |day|
  Day.find_or_create_by(name: day)
end

p "Created Days"

100.times do |i|
  user = User.create(email: "foo#{i}@bar.com", password: '12345678')
  user.confirm

  ProfileLanguage.find_or_create_by(profile_id: user.profile.id, language_id: rand(10)+1, difficulty_id: rand(4)+1)
  ProfileLanguage.find_or_create_by(profile_id: user.profile.id, language_id: rand(10)+1, difficulty_id: rand(4)+1)
  ProfileLanguage.find_or_create_by(profile_id: user.profile.id, language_id: rand(10)+1, difficulty_id: rand(4)+1)
  ProfileLanguage.find_or_create_by(profile_id: user.profile.id, language_id: rand(10)+1, difficulty_id: rand(4)+1)

  start_time = Time.at(50400).utc
  end_time = Time.at(51300).utc
  new_timeslot = Timeslot.find_or_create_by(start_time: start_time, end_time: end_time)
  new_day = Day.find(rand(7)+1)
  DayTimeslot.find_or_create_by(day_id: new_day.id, timeslot_id: new_timeslot.id,
    owner_id: user.profile.id, owner_type: user.profile.class)
  p "created #{i} users" if i % 20 == 0
end

p "Created Users"

1000.times do |i|
  p = Project.create(title: "my #{i}th project", difficulty_id: rand(4)+1,
                 availability: 'weekends')

  owner_id = rand(User.count)+1

  member_id = 0

  loop do
    member_id = rand(User.count)+1
    break if member_id != owner_id
  end

  p.memberships.create(user_id: owner_id, participant_type: "owner")
  p.memberships.create(user_id: member_id, participant_type: "member")

  ProjectLanguage.find_or_create_by(project_id: p.id, language_id: rand(10)+1)
  ProjectLanguage.find_or_create_by(project_id: p.id, language_id: rand(10)+1)
  ProjectLanguage.find_or_create_by(project_id: p.id, language_id: rand(10)+1)
  ProjectLanguage.find_or_create_by(project_id: p.id, language_id: rand(10)+1)

  start_time = Time.at(50400).utc
  end_time = Time.at(51300).utc
  new_timeslot = Timeslot.find_or_create_by(start_time: start_time, end_time: end_time)
  new_day = Day.find(rand(7)+1)
  DayTimeslot.find_or_create_by(day_id: new_day.id, timeslot_id: new_timeslot.id,
    owner_id: p.id, owner_type: p.class)


  p "created #{i} projects" if i % 50 == 0
end


p "Done"


