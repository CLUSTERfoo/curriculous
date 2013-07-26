class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    # clear columns cache
    User.reset_column_information
    # populate all with false
    reversible do |direction|
      direction.up { User.update_all admin: false }
    end
  end
end
