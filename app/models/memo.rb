class Memo < ActiveRecord::Base
  belongs_to :user

  # memo relationship
  has_many :memo_relationships, foreign_key: :parent_memo_id, 
           dependent: :destroy 
  has_many :inverse_memo_relationships, class_name: "MemoRelationship",
           foreign_key: :child_memo_id, dependent: :destroy 
  has_many :child_memos, through: :memo_relationships, 
            source: :child_memo
  has_many :parent_memos, through: :inverse_memo_relationships, 
            source: :parent_memo

  default_scope -> { order 'created_at DESC' }
  
  validates :content, presence: true, length: { minimum: 40 }
  validates :subject, presence: true, length: 7..140
  validates :user_id, presence: true
end
