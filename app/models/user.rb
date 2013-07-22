class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_save { self.username = username.downcase }

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  # TODO: get actual email validation.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
end
