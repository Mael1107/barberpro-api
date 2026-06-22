class CreateBarberSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :barber_schedules do |t|
      t.references :barber_profile, null: false, foreign_key: true
      t.integer :weekday, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.timestamps
    end

    add_index :barber_schedules, [:barber_profile_id, :weekday], unique: true
  end
end
