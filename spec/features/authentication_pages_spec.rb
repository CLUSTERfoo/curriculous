require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "Sign in page" do
    before { visit signin_path }

    it { should have_title(full_title('Sign in')) }
  end

  describe "Signin" do
    before { visit signin_path }
    
    describe "With valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in 'Username',   with: user.username
        fill_in 'Password',   with: "noampass"
        click_button 'Sign in'
      end

      it { should have_selector('div.success')}
      it { should have_title(full_title('')) }
      it { should have_link('Sign out') }
      it { should have_link('Profile') }
      it { should_not have_link('Sign in') }
      it { should_not have_link('Sign up') }

      describe "User links" do
        it "Should have a Profile link that works"
        it "Should have a Sign out link that works"
      end
    end

    describe "With invalid information" do
      before { click_button "Sign in" }
      it { should have_title(full_title('Sign in')) }
      it { should have_selector('div.alert', text: 'Login failed.') }
    end
  end
end
