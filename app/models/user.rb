class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :username, presence: true
end
