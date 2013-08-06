class CreateMemoRelationships < ActiveRecord::Migration
  def change
    create_table :memo_relationships, force: true do |t|
      t.integer :parent_memo_id, null: false
      t.integer :child_memo_id, null: false
    end
    add_index :memo_relationships, :parent_memo_id
    add_index :memo_relationships, :child_memo_id
  end
end
