class AddDoerToTask < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks,:doer,:integer
  end
end
