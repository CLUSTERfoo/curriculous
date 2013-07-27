require 'spec_helper'

describe Memo do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @memo = user.memos.build( subject: "Hello world", 
                      content: "Hi, this is my first post",
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
end
