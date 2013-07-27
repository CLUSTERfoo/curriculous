require 'spec_helper'

describe Memo do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @memo = user.memos.build(subject: "Hello world", 
                            content: "Hi, this is my first post. I am adding 
                                      some filler to make it to 40 chars.",
                            user_id: user.id)
  end

  subject { @memo }

  it { should respond_to(:subject) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  its(:user) { should == user }

  it { should be_valid }

  describe "When user id is not present" do
    before { @memo.user_id = nil }
    it { should_not be_valid }
  end

  describe "With no subject" do
    before { @memo.subject = " " }
    it { should_not be_valid }
  end

  describe "With content that is too short" do
    before { @memo.subject = "a" * 6 }
    it { should_not be_valid }
  end

  describe "With no content" do
    before { @memo.content = " " }
    it { should_not be_valid }
  end

  describe "With content that is too short" do
    before { @memo.content = "a" * 38 }
    it { should_not be_valid }
  end
end
