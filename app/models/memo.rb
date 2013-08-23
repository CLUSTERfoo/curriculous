class Memo < ActiveRecord::Base
  attr_reader :token

  belongs_to :user
  before_save :create_reationships
  after_initialize :init

  def init
    self.content ||= ""
  end

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
  
  validates :subject, presence: true, length: 7..140
  validates :content, length: 0..15001
  validates :user_id, presence: true

  validate :content_is_not_nil

  def content_is_not_nil
    errors.add :content, 'Content can not be nil' if content.nil? 
  end
  
  validate :parent_memo_must_exist

  # make base 36 token for readability
  def self.token_exists?(token)
    exists?(token.to_i(36)) 
  end

  def self.find_by_token(token)
    find(token.to_i(36))
  end

  def token
    id.to_s(36).upcase
  end

  private

  def parent_memo_must_exist
    hash = build_hash
    hash[:relationships][:memo].each do |token|
      if !Memo.token_exists?(token)
        errors.add :derp!, "You wrote \"@#{ token }\", but that memo 
          doesn't actually exist!"
      end
    end
  end
   
  def create_reationships
    hash = build_hash
    hash[:relationships][:memo].each do |token|
      parent = Memo.find_by_token(token)
      parent_memos << parent
    end
  end

  def build_hash
    defaults = { relationships: %i(memo error user), tags: %i(tag) }
    defaults.each {|k, v| defaults[k] = v.inject({}){|h, k| h[k] = []; h } } 
    hash = MemoParser.to_hash(content)
    hash = defaults.merge(hash)
  end
end
