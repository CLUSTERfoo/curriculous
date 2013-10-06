class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_save do 
    self.display_name = username if self.display_name == nil
    self.username = username.downcase
  end

  has_many :memos, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }
# # TODO: get actual email validation.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX, allow_blank: true }
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates :password, presence: true

  # TODO: This really should be a single query...
  def replies
    replies = []
    memos.each do |memo|
      memo.child_memos.each  do |child|
        replies << child unless child.user.username == username
      end
    end
    replies
  end
end
