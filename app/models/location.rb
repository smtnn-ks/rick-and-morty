class Location < ApplicationRecord
  validates :name, presence: true
  validates :location_type, presence: true
  validates :dimensions, presence: true

  has_many :origin_characters, class_name: "Character", foreign_key: "origin_location_id"
  has_many :characters, class_name: "Character", foreign_key: "location_id"
end
