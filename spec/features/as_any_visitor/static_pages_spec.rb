require 'spec_helper'

describe "Browsing site as any visitor" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let!(:memo) { FactoryGirl.create(:memo, user: user) }

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

  describe "User profile page" do
    before { visit user_path(user.username) }

    it { should have_title(full_title(user.username)) }
    it { should have_content(user.username.capitalize) }
    it { should have_selector("div.memo") }
  end
end
