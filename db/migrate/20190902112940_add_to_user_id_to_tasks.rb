class AddToUserIdToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks,:user_id,:integer
    remove_column :tasks,:creater,:integer
  end
end
