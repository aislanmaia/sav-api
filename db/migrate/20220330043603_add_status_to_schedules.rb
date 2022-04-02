class AddStatusToSchedules < ActiveRecord::Migration[6.0]
  def up
    # execute <<-SQL
    #   CREATE TYPE schedule_status AS ENUM ('open', 'cancelled', 'finished');
    # SQL
    add_column :schedules, :status, :string
    add_index :schedules, :status
  end

  def down
    remove_column :schedules, :status
    # execute <<-SQL
    #   DROP TYPE schedule_status;
    # SQL
  end
end
