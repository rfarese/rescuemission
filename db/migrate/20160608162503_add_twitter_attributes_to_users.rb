class AddTwitterAttributesToUsers < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
    add_column :users, :profile_image, :string
  end
  def down
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :name, :string
    remove_column :users, :token, :string
    remove_column :users, :secret, :string
    remove_column :users, :profile_image, :string
  end
end
