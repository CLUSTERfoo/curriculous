require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }
    it { should have_title(full_title('')) }
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
