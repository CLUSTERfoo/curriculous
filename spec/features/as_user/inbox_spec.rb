require 'spec_helper'

describe "Inbox page" do
  subject { page }

  # Setup and teardown

  before(:all) do
    @user = FactoryGirl.create(:user)
    @user_attr = FactoryGirl.build(:user)
    @other_user = FactoryGirl.create(:user, username: "other")
    @users_memo = FactoryGirl.create(:memo, user: @user)
    # NOTE: FactoryGirl not building relationships?
    @user_reply = @user.memos.create(
      subject: "Child Memo", 
      content: "same user's reply @#{ @users_memo.token }", user_id: @user.id
    )
    @reply = @other_user.memos.create(
      subject: "Child Memo", 
      content: "reply to @#{ @users_memo.token }", user_id: @user.id
    )
  end

  after(:all) do
    @user.destroy
    @users_memo.destroy
    @reply.destroy
    @other_user.destroy
    @user_reply.destroy
  end

  before do
    sign_in(@user_attr)
    visit inbox_path 
  end

  # Tests

  it { should have_content("Inbox") }
  it { should have_title(full_title("Inbox")) }
  it { should have_content(@reply.content) }
  it { should_not have_content(@user_reply.content) }
end
