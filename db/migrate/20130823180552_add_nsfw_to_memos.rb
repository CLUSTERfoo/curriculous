class AddNsfwToMemos < ActiveRecord::Migration
  class Memo < ActiveRecord::Base
  end

  def change
    add_column :memos, :nsfw, :boolean, default: false

    Memo.reset_column_information
    reversible do |direction|
      direction.up { Memo.update_all nsfw: false }
    end
  end
end
