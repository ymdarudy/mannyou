class AddColumnToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :expired_at, :datetime, precision: 6, null: false
  end
end
