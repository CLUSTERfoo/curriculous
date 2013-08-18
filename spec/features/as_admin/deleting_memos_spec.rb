require 'spec_helper'

describe "Deleting memos as Admin" do
  subject { page }

  before(:all) do
    @admin = FactoryGirl.create(:admin, username: "Admin")
    @admin_attr = FactoryGirl.build(:admin, username: "Admin")
    @user = FactoryGirl.create(:user)
  end

  after(:all) do
    @admin.destroy
    @user.destroy
    @memo.destroy
  end

  before do
    sign_in(@admin_attr)
    @memo = FactoryGirl.create(:memo, user: @user)
    visit memo_path(@memo.token)
  end

  it { should have_title(full_title(@memo.subject)) }
  it { should have_link('Delete', memo_url(@memo.token)) }
  it "Should be able to delete a memo" do
    expect do
      click_link('Delete', match: :first)
    end.to change(Memo, :count).by(-1)
  end
end
