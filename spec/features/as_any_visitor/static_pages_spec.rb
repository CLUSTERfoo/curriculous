require 'spec_helper'

describe "Browsing site as any visitor" do
  subject { page }

  before do
    @user = FactoryGirl.create(:user)
    @memo = FactoryGirl.create(:memo, user: @user, subject: "Foo Foo", 
                                        content: "foo" * 40)
  end

  describe "Home Page" do
    before { visit root_path }
    it { should have_title(full_title('')) }
    it { should have_link('Post a memo') }
    it { should have_selector("div.memo-header") }
  end

  describe "About Page" do
    before { visit about_path }
    it { should have_title(full_title('About')) }
  end 

  describe "Memo page" do
    before { visit memo_path(@memo.token) }

    it { should have_title(full_title(@memo.subject)) }
    it { should have_content(@memo.subject) }
    it { should have_content(@memo.content) }
    it "Write NSFW memo tests, ya lazy bum!"
  end

  describe "User profile page" do
    before { visit user_path(@user.username) }

    it { should have_title(full_title(@user.username)) }
    it { should have_content(@user.username.capitalize) }
    it { should have_selector("div.memo") }
  end
end
