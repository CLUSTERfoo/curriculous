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
end
