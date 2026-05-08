class CreateServices < ActiveRecord::Migration[8.1]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :duration_minutes, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
