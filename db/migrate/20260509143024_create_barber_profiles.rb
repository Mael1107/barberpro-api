class CreateBarberProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :barber_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.text :bio
      t.string :photo_url
      t.string :instagram

      t.timestamps
    end
  end
end
