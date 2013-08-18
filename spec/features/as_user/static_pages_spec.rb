require 'spec_helper'

describe "Browsing site as signed in user" do
  subject { page }

  before(:all) do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user, username: "John")
    @user_attr = FactoryGirl.build(:user)
    @memo = FactoryGirl.create(:memo, user: @other_user)
  end

  after(:all) do
    @user.destroy
    @other_user.destroy
    @memo.destroy
  end

  before do
    sign_in(@user_attr)
  end

  describe "Memo page" do
    before { visit memo_path(@memo.token) }

    it { should have_title(full_title(@memo.subject)) }
    it { should_not have_link('Delete') }
  end
end
