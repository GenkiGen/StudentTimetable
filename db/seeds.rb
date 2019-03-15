# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create 50 students
Learner.create(id: 1, name: 'John Cena', email: 'john@email.com', password: 'Rm!t201278', password_confirmation: 'Rm!t201278', activated: true, activated_at: Time.zone.now, time_zone: 'Hanoi')
50.times do |n|
    name = Faker::Name.name
    email = Faker::Internet.email
    password = 'Rm!t201278'
    time_zone = 'Hanoi'
    
    Learner.create(id: n+2, name: name, email: email, password: password, password_confirmation: password, activated: true, 
        activated_at: Time.zone.now, time_zone: time_zone)
end

# Create 30 teachers
Teacher.create(id: 53, name: 'Johny Legond', email: 'legond@email.com', password: 'Rm!t201278', password_confirmation: 'Rm!t201278', activated: true, activated_at: Time.zone.now, time_zone: 'Hanoi')
30.times do |n|
    name = Faker::Name.name
    email = Faker::Internet.email
    password = 'Rm!t201278'
    time_zone = 'Hanoi'

    Teacher.create(id: n+54, name: name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now, time_zone: time_zone)
end

# Create courses that belongs to those 30 teachers
30.times do
    code = Faker::Code.asin
    course_name = Faker::Educator.course_name
    Teacher.first.courses.create(name: course_name, code: code)
end

Teacher.first(11).each do |teacher|
    # Create 2 courses for each teacher
    2.times do
        code = Faker::Code.asin
        course_name = Faker::Educator.course_name
        teacher.courses.create(name: course_name, code: code)
    end
end

Teacher.first(20).each do |teacher|
    # Create 2 courses for each teacher
    2.times do
        code = Faker::Code.asin
        course_name = Faker::Educator.course_name
        teacher.courses.create(name: course_name, code: code)
    end
end

# Learners following courses
Course.first(30).each do |course|
    Learner.first(10).each do |learner|
        learner.follow_course(course)
    end
end

Course.last(20).each do |course|
    Learner.last(45).each do |learner|
        learner.follow_course(course)
    end
end


# Create schedules that belongs to those 30 courses