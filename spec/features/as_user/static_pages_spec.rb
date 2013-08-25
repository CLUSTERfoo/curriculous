require 'spec_helper'

describe "Browsing site as signed in user" do
  subject { page }

  let(:user_attr) {FactoryGirl.build(:user)}
  let(:user) {FactoryGirl.create(:user)}
  let(:other_user) {FactoryGirl.create(:user, username: "John")}
  let(:memo) {FactoryGirl.create(:memo, user: other_user)}
    
  before { sign_in(user_attr) }

  describe "Memo page" do
    before { visit memo_path(memo.token) }

    it { should have_title(full_title(memo.subject)) }
    it { should_not have_link('Delete') }
  end
end
