require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }
    it { should have_title(full_title('')) }
    it { should have_link('Sign in') }
    it { should have_link('Sign up') }
    it { should have_link('Post a memo') }
    
    describe "When unsigned user tries to create memo" do
      before { click_link('Post a memo') }
      it { should have_title(full_title('Sign up')) }
    end
  end

  describe "About Page" do
    before { visit about_path }
    it { should have_title(full_title('About')) }
  end 

  describe "Contribute Page" do
    before { visit contribute_path }
    it { should have_title(full_title('Contribute')) }
  end


end
