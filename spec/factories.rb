FactoryGirl.define do
  factory :user do
    username              "noam"
    email                 "noam@email.com"
    password              "noampass"
    password_confirmation "noampass"
    #crypted_password      Sorcery::CryptoProviders::BCrypt.encrypt(
    #                        "secret", "asdasdastr4325234324sdfds"
    #                      )
  end
end
