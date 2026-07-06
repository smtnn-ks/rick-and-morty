# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_05_234120) do
  create_table "characters", force: :cascade do |t|
    t.string "character_type"
    t.datetime "created_at", null: false
    t.string "gender"
    t.integer "location_id"
    t.string "name"
    t.integer "origin_location_id"
    t.string "species"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_characters_on_location_id"
    t.index ["origin_location_id"], name: "index_characters_on_origin_location_id"
  end

  create_table "characters_episodes", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "episode_id", null: false
    t.index ["character_id", "episode_id"], name: "index_characters_episodes_on_character_id_and_episode_id"
    t.index ["episode_id", "character_id"], name: "index_characters_episodes_on_episode_id_and_character_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.datetime "air_date"
    t.datetime "created_at", null: false
    t.string "episode_code"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "dimensions"
    t.string "location_type"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "locations"
  add_foreign_key "characters", "locations", column: "origin_location_id"
end
