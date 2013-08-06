class MemoRelationship < ActiveRecord::Base
  belongs_to :parent_memo, class_name: "Memo"
  belongs_to :child_memo, class_name: "Memo"
end
