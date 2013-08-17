require 'spec_helper'

describe "Inbox page" do
  subject { page }

  before(:all) do
    @user = FactoryGirl.create(:user)
    @user_attr = FactoryGirl.build(:user)
    @users_memo = FactoryGirl.create(:memo, user: @user)
    # NOTE: FactoryGirl not building relationships?
    @reply = @user.memos.create(subject: "Child Memo", 
        content: "reply to @#{ @users_memo.token }", user_id: @user.id)
  end

  after(:all) do
    @user.destroy
    @users_memo.destroy
    @reply.destroy
  end

  before do
    sign_in(@user_attr)
    visit inbox_path 
  end

  it { should have_content("Inbox") }
  it { should have_title(full_title("Inbox")) }
  it { should have_content(@reply.content) }
end
