class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.string :subject
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
    add_index :memos, :created_at
    add_index :memos, [:user_id, :created_at]
  end
end
