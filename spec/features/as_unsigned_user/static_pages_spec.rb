require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }
    it { should have_link('Sign in') }
    it { should have_link('Sign up') }
  end

  describe "Signup page" do
    before { visit signup_path }
    it { should have_content("Sign up") }
    it { should have_title(full_title('Sign up')) }
  end

  describe "Sign in page" do
    before { visit signin_path }
    it { should have_title(full_title('Sign in')) }
  end

  describe "Inbox page" do
    before { visit inbox_path }
    it { should have_title(full_title('Sign up')) }
  end

  describe "New memo page" do
    before { visit new_memo_path }
    it { should have_title(full_title('Sign up')) }
  end
end
