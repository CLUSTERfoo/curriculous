require 'spec_helper'

describe Memo do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @memo = user.memos.build(subject: "Hello world", content: "#{ 'a ' * 40 }", 
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

  describe "With no content is blank string" do
    before do
      @memo_blank = user.memos.build(subject: "Hello world", user_id: user.id)
    end
    it { expect(@memo_blank.content).to eq "" }
  end

  describe "Base-36 token representation of ID" do
    before do
      @memo.save
      @id = @memo.id
      @token = @memo.token
    end

    specify "Find by token should get correct memo" do
      expect(Memo.find(@id)).to eq Memo.find_by_token(@token)
    end

    specify "Token exists? should check for the right memo" do
      expect(Memo.token_exists?(@token)).to be_true 
      @memo.destroy
      expect(Memo.token_exists?(@token)).to be_false
    end
  end
end
