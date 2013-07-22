require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'What is this?" do
      visit '/'
      expect(page).to have_content('What is this?')
    end
  end
end
