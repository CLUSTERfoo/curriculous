require 'spec_helper'

describe "Inbox page" do
  subject { page }

  let!(:user) {FactoryGirl.create(:user)}
  let(:user_attr) {FactoryGirl.build(:user)}
  let(:other_user) {FactoryGirl.create(:user, username: "other")}
  let(:users_memo) {FactoryGirl.create(:memo, user: user)}
  let(:user_reply) {FactoryGirl.create(:memo, 
                    content: "same user reply to @#{ users_memo.token }", 
                    user: user)}
  let!(:reply) {FactoryGirl.create(:memo, 
                content: "other user reply to @#{ users_memo.token }", 
                user: other_user)}

  before do
    sign_in(user_attr)
    visit inbox_path 
  end

  # Tests

  it { should have_content("Inbox") }
  it { should have_title(full_title("Inbox")) }
  it { should have_content(reply.content) }
  it { should_not have_content(user_reply.content) }
end
