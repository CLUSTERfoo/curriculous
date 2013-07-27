require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "Signup page" do
    before { visit signup_path }
    it { should have_content("Sign up") }
    it { should have_title(full_title('Sign up')) }
  end

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:memo1) { FactoryGirl.create(:memo, user: user, subject: "Foo Foo", 
                                      content: "foo" * 40) }
    let!(:memo2) { FactoryGirl.create(:memo, user: user, subject: "Bar Bar", 
                                      content: "bar" * 40) }
    before { visit user_path(user) }

    it { should have_title(full_title(user.username)) }
    it { should have_content(user.username) }

    describe "Memos" do
      it { should have_content(memo1.subject) }
      it { should have_content(memo2.subject) }
    end
  end

  describe "Signup" do
    before { visit signup_path }

    let(:submit) { "Create new account" }

    describe "With invalid information" do
      it "Should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
        page.should have_selector('div.alert')
      end

    end

    describe "With valid information" do
      before do
        fill_in "Username",     with: "Noam"
        fill_in "Email",        with: "noam@email.com"
        fill_in "Password",     with: "noampass"
        fill_in "Password confirmation", with: "noampass"
      end

      it "Should create a new user" do
        expect { click_button submit }.to change(User, :count)
        page.should have_css('div.success')
      end

      it "Should log the user in" do
        click_button submit
        page.should have_link("Sign out")
      end

    end
  end
end
