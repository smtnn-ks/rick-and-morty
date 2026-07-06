class CreateCharacters < ActiveRecord::Migration[8.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :status
      t.string :species
      t.string :character_type, null: true
      t.string :gender

      t.references :origin_location, foreign_key: { to_table: :locations }, null: true
      t.references :location, foreign_key: { to_table: :locations }, null: true

      t.timestamps
    end
  end
end
