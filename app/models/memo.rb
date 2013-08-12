class Memo < ActiveRecord::Base
  attr_reader :token

  belongs_to :user
  before_save :create_reationships

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
  
  validates :content, presence: true, length: { minimum: 7 }
  validates :subject, presence: true, length: 7..140
  validates :user_id, presence: true

  # make base 36 token for readability
  def self.find_by_token(token)
    find(token.to_i(36))
  end

  def token
    id.to_s(36).upcase
  end

  private
   
  def create_reationships
    defaults = { relationships: %i(memo error user), tags: %i(tag) }
    defaults.each {|k, v| defaults[k] = v.inject({}){|h, k| h[k] = []; h } } 
    hash = MemoParser.to_hash(content)
    hash = defaults.merge(hash)
    hash[:relationships][:memo].each do |token|
      parent = Memo.find_by_token(token)
      parent_memos << parent
    end
  end
end
