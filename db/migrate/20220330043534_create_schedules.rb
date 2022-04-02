class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.belongs_to :client, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :scheduling_date

      t.timestamps
    end
  end
end
