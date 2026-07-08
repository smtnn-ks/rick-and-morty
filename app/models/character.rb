class Character < ApplicationRecord
  validates :name, presence: true
  validates :species, presence: true
  validates :character_type, presence: true, allow_nil: true
  validates :created_at, presence: true

  enum :status, { alive: "Alive", dead: "Dead", unknown: "unknown" }
  enum :gender, { male: "Male", female: "Female", genderless: "Genderless", other: "unknown" }

  belongs_to :origin_location, class_name: "Location", foreign_key: "origin_location_id", optional: true
  belongs_to :location, class_name: "Location", foreign_key: "location_id", optional: true

  has_and_belongs_to_many :episodes
end
