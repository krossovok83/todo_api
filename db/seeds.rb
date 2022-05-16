# frozen_string_literal: true

User.create!(
  email: 'admin@example.com',
  password: 'password'
)

2.times do
  Project.create!(
    title: ::FFaker::Color.name,
    user: User.first
  )
end

Project.all.each do |project|
  5.times do
    Task.create!(
      title: ::FFaker::Company.catch_phrase,
      project: project
    )
  end
end

Task.all.each do |task|
  3.times do
    Comment.create!(
      body: ::FFaker::Lorem.phrase,
      task: task
    )
  end
end