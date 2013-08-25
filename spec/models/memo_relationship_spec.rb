require 'spec_helper'

describe MemoRelationship do
  let(:user) { FactoryGirl.create(:user) }
  let(:parent) { FactoryGirl.create(:memo, subject: "Parent Memo", user: user) }
  let(:child) { FactoryGirl.build(:memo, content: "@#{ parent.token }", user: user) }
        
  describe "Memo content has valid @relation" do
    it "Creates a new relationship" do
      expect { child.save }.to change(MemoRelationship, :count) 
    end

    it "Creates a new child relationship" do
      expect { child.save }.to change(parent.child_memos, :count) 
    end

    specify "Child responds to parent" do
      child.save
      expect(child.parent_memos.find(parent.id).id).to eq(parent.id)
    end
    
    specify "Parent responds to child" do
      child.save
      expect(parent.child_memos.find(child.id).id).to eq(child.id)
    end
  end

  describe "Memo content has invalid @relation" do
    specify "Memo not to be valid" do
      parent.destroy
      expect(child).not_to be_valid
    end
  end
end
