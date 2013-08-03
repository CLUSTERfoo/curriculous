require 'spec_helper'

describe "Signing up" do
  subject { page }

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
