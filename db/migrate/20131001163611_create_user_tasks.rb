class CreateUserTasks < ActiveRecord::Migration

  def up
    create_table :tasks_users, :id => false do |t|
      t.integer :user_id
      t.integer :task_id
    end
  end

  def down
    drop_table :tasks_users
  end

end
