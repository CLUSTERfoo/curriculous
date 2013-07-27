FactoryGirl.define do
  factory :user do
    username              "noam"
    email                 "noam@email.com"
    password              "noampass"
    password_confirmation "noampass"
    
    factory :admin do
      admin true
    end
  end

  factory :memo do
    subject             "Hello world!"
    content             "Something something really interesting content.
                          Must make it to 40 chars or it'll be invalid."
    user
  end
end
