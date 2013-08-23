require 'spec_helper'

describe User do
  before do
    @user = User.new( username: "sample_user", email: "sample_user@example.com",
                      password: "realpassword", 
                      password_confirmation: "realpassword")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:crypted_password) }
  it { should respond_to(:admin) }
  it { should respond_to(:memos) }
  it { should respond_to(:replies) }
  it { should respond_to(:remember_me_token) }
  it { should respond_to(:remember_me_token_expires_at) }

  it { should be_valid }
  it { should_not be_admin }


  # Username tests

  describe "when username is not present" do
      before { @user.username = "" }
      it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end
    it { should_not be_valid }
  end

  # Password tests

  describe "when password is not present" do
    before do
      @user = User.new( username: "sample_user", 
                        email: "sample_user@example.com",
                        password: "", password_confirmation: "")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  # Email tests

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is not present" do
    it "should be valid" do
      @user.email = ""
      @user2 = User.new(username: "user2", password: "12345", 
                        password_confirmation: "12345")
      expect(@user).to be_valid
      expect(@user2).to be_valid
    end
  end

  # Admin tests

  describe "With admin attribute set to true" do
    before do
      @user.save!
      @user.toggle!(:admin)

      it { should be_admin }
    end
  end

  # Memos tests

  describe "Micropost associations" do
    before { @user.save }
    # NOTE: Force with let! because let is lazily evaluated
    # TODO: not sure in which order these are actually evaluated. This is hacky.
    let!(:middle_memo) {  FactoryGirl.create(:memo, user: @user,
                                             created_at: 3.hours.ago) }
    let!(:newer_memo) { FactoryGirl.create(:memo, user: @user,
                                           created_at: 1.hour.ago) }
    let!(:older_memo) { FactoryGirl.create(:memo, user: @user,
                                           created_at: 1.day.ago ) }

    it "Should have the right memos in the right order" do
      expect(@user.memos.to_a).to eq [newer_memo, middle_memo, older_memo]
    end
  end

  describe "Replies" do
    before { 
      @user.save 
      @user2 = FactoryGirl.create(:user, username: "poo")
      @middle_memo = FactoryGirl.create(:memo, user: @user)
      @reply = FactoryGirl.create(:memo, content: "reply to @#{ @middle_memo.token }", user: @user2)
      @user_reply = FactoryGirl.create(:memo, user: @user, content: "reply to @#{ @middle_memo.token }") 
    }

    it "Should show up" do
      expect(@user.replies).to eq [@reply]
    end
  end
end
