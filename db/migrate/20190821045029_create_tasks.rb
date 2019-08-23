class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :content
      t.date :deadline
      t.string :image_name
      t.string :doer

      t.timestamps
    end
  end
end
