class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :location_type, null: false
      t.string :dimension, null: false

      t.timestamp :created_at, null: false
    end
  end
end
