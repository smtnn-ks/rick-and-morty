class CreateCharacters < ActiveRecord::Migration[8.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :status, null: false
      t.string :species, null: false
      t.string :character_type, null: true
      t.string :gender, null: false

      t.references :origin_location, foreign_key: { to_table: :locations }, null: true
      t.references :location, foreign_key: { to_table: :locations }, null: true

      t.timestamp :created_at, null: false
    end
  end
end
