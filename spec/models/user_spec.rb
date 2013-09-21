require 'spec_helper'

describe User do
  let(:user_attr) { FactoryGirl.build(:user) }
  let(:user) { FactoryGirl.create(:user) }

  subject { user_attr }

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
  it { should respond_to(:display_name) }

  it { should be_valid }
  it { should_not be_admin }


  # Username tests
  describe "When username is not present" do
      before { user.username = "" }
      it { should_not be_valid }
  end

  describe "When username is already taken" do
    before do
      user_with_same_username = user.dup
      user_with_same_username.username = user.username.upcase
      user_with_same_username.save
    end
    it { should_not be_valid }
  end

  describe "When username has variable casing" do
    let(:user2) { FactoryGirl.create(:user, username: "Poo") }

    specify "Display name should retain it" do
      expect(user2.display_name).to eq "Poo"
    end
  end



  # Password tests
  describe "When password is not present" do
    before do
      user_attr.password = ""
      user_attr.password_confirmation = ""
    end
    it { should_not be_valid }
  end

  describe "When password doesn't match confirmation" do
    before { user_attr.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end



  # Email tests
  describe "When email format is invalid" do
    it "Should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]

      addresses.each do |invalid_address|
        user_attr.email = invalid_address
        expect(user_attr).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "Should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]

      addresses.each do |valid_address|
        user_attr.email = valid_address
        expect(user_attr).to be_valid
      end
    end
  end

  describe "When email is not present" do
    it "Should be valid" do
      user_attr.email = ""
      expect(user_attr).to be_valid
    end
  end



  # Admin tests
  describe "with admin attribute set to true" do
    subject { user }
    before { user.toggle!(:admin) }
    it { should be_admin }
  end



  # Memos tests
  describe "Micropost associations" do
    # NOTE: Force with let! because let is lazily evaluated
    # TODO: not sure in which order these are actually evaluated. This is hacky.
    let!(:middle_memo) {  FactoryGirl.create(:memo, user: user,
                                             created_at: 3.hours.ago) }
    let!(:newer_memo) { FactoryGirl.create(:memo, user: user,
                                           created_at: 1.hour.ago) }
    let!(:older_memo) { FactoryGirl.create(:memo, user: user,
                                           created_at: 1.day.ago ) }

    it "Should have the right memos in the right order" do
      expect(user.memos.to_a).to eq [newer_memo, middle_memo, older_memo]
    end
  end

  describe "Replies" do
    let(:user2) { FactoryGirl.create(:user, username: "poo") }
    let(:middle_memo) { FactoryGirl.create(:memo, user: user) }
    let!(:reply) { FactoryGirl.create(:memo, content: "reply to @#{ middle_memo.token }", user: user2) }
    let!(:user_reply) { FactoryGirl.create(:memo, user: user, content: "reply to @#{ middle_memo.token }") } 

    it "Should show up" do
      expect(user.replies).to eq [reply]
    end
  end
end
