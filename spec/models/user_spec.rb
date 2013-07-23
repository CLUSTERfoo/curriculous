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
  it { should be_valid }

  # username tests

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

  # password tests

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

  # email tests

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
end
