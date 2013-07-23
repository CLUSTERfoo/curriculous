require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }
    it { should have_content("What is this?") }
    it { should have_title(full_title('')) }
  end
end
