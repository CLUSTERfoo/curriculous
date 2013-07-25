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
        fill_in username,   with: user.username.upcase
        fill_in password,   with: user.password
        click_button 'Sign in'
      end

      it { should have_selector('div.success', text: user.username) }
      it { should have_title(full_title('')) }
      it { should have_link('Sign out') }
      it { should have_link('Profile') }
      it { should_not have_link('Sign in') }
      it { should_not have_link('Sign up') }
    end

    describe "With invalid information" do
      it { should have_title(full_title('Sign in')) }
      it { should have_selector('div.alert', text: 'Invalid') }
    end
  end
end
