require 'spec_helper'

describe "Memo pages" do
  subject { page }


  describe "New memo" do

    # NOTE: let! or tests break because of lazy loading
    let!(:user) { FactoryGirl.create(:user) }
    let(:user_attr) { FactoryGirl.build(:user) }

    before do
      sign_in(user_attr)
      visit new_memo_path
    end

    it { should have_content("New memo") }
    it { should have_content("Sign out") }
    it { should have_title(full_title("New memo")) }

    let(:submit) { "Post memo" }

    describe "With invalid information" do
      it "Should not create a memo" do
        expect { click_button submit }.not_to change(Memo, :count)
        page.should have_selector('div.alert')
      end
    end

    describe "With valid information" do
      before do
        fill_in "Subject",      with: "Hello this is title"
        fill_in "Content",        with: "This will be long nuff: #{ 'hi' * 40 }"
      end

      it "Should create a new memo" do
        expect { click_button submit }.to change(Memo, :count)
        page.should have_css('div.success')
        page.should have_title(full_title("Hello this is title"))
      end
    end

    describe "Memo page" do
      let!(:memo) { FactoryGirl.create(:memo, user: user, subject: "Foo Foo", 
                                        content: "foo" * 40) }
      before { visit memo_path(memo) }

      it { should have_title(full_title(memo.subject)) }
      it { should have_content(memo.subject) }
      it { should have_content(memo.content) }
    end
  end
end
