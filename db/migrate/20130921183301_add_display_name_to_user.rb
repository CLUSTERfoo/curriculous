class AddDisplayNameToUser < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  def change
    add_column :users, :display_name, :string

    User.reset_column_information
    reversible do |direction|
      direction.up { User.update_all "display_name = username" }
    end
  end
end
