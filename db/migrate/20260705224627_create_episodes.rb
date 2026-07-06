class CreateEpisodes < ActiveRecord::Migration[8.1]
  def change
    create_table :episodes do |t|
      t.string :name
      t.timestamp :air_date
      t.string :episode_code

      t.timestamps
    end
  end
end
