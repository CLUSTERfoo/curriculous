require 'spec_helper'

describe Memo do
  let(:user) { FactoryGirl.create(:user) }
  let(:memo) { FactoryGirl.build(:memo, user: user) }

  subject { memo }

  it { should respond_to(:subject) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:memo_relationships) }
  it { should respond_to(:inverse_memo_relationships) }
  it { should respond_to(:child_memos) }
  it { should respond_to(:parent_memos) }
  it { should respond_to(:nsfw) }
  its(:user) { should == user }

  it { should be_valid }

  describe "When user id is not present" do
    before { memo.user_id = nil }
    it { should_not be_valid }
  end

  describe "With no subject" do
    before { memo.subject = " " }
    it { should_not be_valid }
  end

  describe "With subject that is too short" do
    before { memo.subject = "a" * 6 }
    it { should_not be_valid }
  end

  describe "With subject that is too long" do
    before { memo.subject = "a" * 141 }
    it { should_not be_valid }
  end

  describe "With content that is too long" do
    before { memo.subject = "a" * 15002 }
    it { should_not be_valid }
  end



  describe "With no content is blank string" do
    let(:memo_blank) { user.memos.build(subject: "Something something") }
    it { expect(memo_blank.content).to eq "" }
  end



  describe "Base-36 token representation of ID" do
    before do
      memo.save
      @id = memo.id
      @token = memo.token
    end

    specify "Find by token should get correct memo" do
      expect(Memo.find(@id)).to eq Memo.find_by_token(@token)
    end

    specify "Token exists? should check for the right memo" do
      expect(Memo.token_exists?(@token)).to be_true 
      memo.destroy
      expect(Memo.token_exists?(@token)).to be_false
    end
  end
end
