class AddCreaterToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :creater, :string       
  end
end
