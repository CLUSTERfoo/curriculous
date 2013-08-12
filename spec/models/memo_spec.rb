require 'spec_helper'

describe Memo do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @memo = user.memos.build(subject: "Hello world", 
                            content: "#{ 'a ' * 40 }", 
                            user_id: user.id)
  end

  subject { @memo }

  it { should respond_to(:subject) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:memo_relationships) }
  it { should respond_to(:inverse_memo_relationships) }
  it { should respond_to(:child_memos) }
  it { should respond_to(:parent_memos) }
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

  describe "With subject that is too short" do
    before { @memo.subject = "a" * 6 }
    it { should_not be_valid }
  end

  describe "With subject that is too long" do
    before { @memo.subject = "a" * 141 }
    it { should_not be_valid }
  end

  describe "With no content" do
    before { @memo.content = " " }
    it { should_not be_valid }
  end

  describe "With content that is too short" do
    before { @memo.content = "a" * 6 }
    it { should_not be_valid }
  end
end
