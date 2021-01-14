class ChangeDataUserIdToFollow < ActiveRecord::Migration[6.1]
  def change
    change_column :follows, :user_id, :int
    change_column :follows, :follow_user_id, :int
  end
end
