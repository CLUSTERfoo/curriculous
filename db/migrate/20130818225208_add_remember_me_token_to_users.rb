class AddRememberMeTokenToUsers < ActiveRecord::Migration 
  # Local model just in case
  class User < ActiveRecord::Base
  end

  def change 
    add_column :users, :remember_me_token, :string, :default => nil
    add_column :users, :remember_me_token_expires_at, :datetime, :default => nil

    add_index :users, :remember_me_token
  end
end
