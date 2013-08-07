require 'spec_helper'

describe MemoRelationship do
  # The ugliest tests of all time.
  # OF ALL TIME
  
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    @parent = user.memos.create(subject: "Parent Memo",
                                content: "#{ 'a ' * 40 }", user_id: user.id)
  end

  describe "Hardcoding a relationship" do
    before do
      @child = user.memos.create(subject: "Child Memo", 
                                 content: "#{ 'a ' * 40 }", user_id: user.id)
      @parent.child_memos << @child 
    end

    specify "Parent responds to child" do
      child_memo_subject =  @parent.child_memos.find(@child.id).subject 
      expect(child_memo_subject).to eq(@child.subject)
    end

    specify "Child responds to parent" do
      parent_memo_subject =  @child.parent_memos.find(@parent.id).subject 
      expect(parent_memo_subject).to eq(@parent.subject)
    end
  end

  describe "Memo content has @relation" do
    before do
      @child = user.memos.build(subject: "Child Memo", 
                              content: "#{ 'a ' * 40 } 
                                        @#{ @parent.id.to_s(36) }",
                              user_id: user.id)
    end

    it "Creates a new relationship" do
      expect { @child.save }.to change(MemoRelationship, :count) 
    end

    it "Creates a new child relationship" do
      expect { @child.save }.to change(@parent.child_memos, :count) 
    end

    specify "Child responds to parent" do
      @child.save
      expect(@child.parent_memos.find(@parent.id).subject).to eq(@parent.subject)
    end
  end
end
