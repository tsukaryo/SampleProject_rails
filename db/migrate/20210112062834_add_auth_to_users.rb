class AddAuthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mail_auth, :boolean
  end
end
