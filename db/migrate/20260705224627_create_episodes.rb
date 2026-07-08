class CreateEpisodes < ActiveRecord::Migration[8.1]
  def change
    create_table :episodes do |t|
      t.string :name, null: false
      t.timestamp :air_date, null: false
      t.string :code, null: false

      t.timestamp :created_at, null: false
    end
  end
end
