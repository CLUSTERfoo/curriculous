
require 'spec_helper'

describe "Reading a memo as any visitor" do
  subject { page }

  let(:memo) { FactoryGirl.create(:memo) }
  let(:nsfw_memo) { FactoryGirl.create(:memo, nsfw: true) }

  describe "Memo page" do
    before { visit memo_path(memo.token) }

    it { should have_title(full_title(memo.subject)) }
    it { should have_content(memo.subject) }
    it { should have_content(memo.content) }
  end

  describe "NSFW memo page" do
    before { visit memo_path(nsfw_memo.token) }

    it { should have_content(nsfw_memo.subject) }
    it { should have_css(".memo-wrapper.nsfw") }
  end
end
