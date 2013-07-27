namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!( username: "admin",
                  password: "foobar",
                  password_confirmation: "foobar",
                  admin: true)

    @noam = User.create!( username: "noam",
                        password: "noam",
                        password_confirmation: "noam",
                        admin: false)

    99.times do |n|
      name  = "user_number_#{ n+1 }"
      email = "user_number#{n+1}@email.com"
      password  = "password"
      User.create!( username: name,
                    email: email,
                    password: password,
                    password_confirmation: password,
                    admin: false)
    end

    users = User.all(limit: 6)
    99.times do |n|
      subject = Faker::Lorem.sentence(5)
      content = Faker::Lorem.paragraph(10)
      users.each do |user|
        user.memos.create(subject: subject, content: content,
                           created_at: n.hours.ago)
      end
    end
  end
end
