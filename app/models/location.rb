class Location < ApplicationRecord
  validates :name, presence: true
  validates :location_type, presence: true
  validates :dimension, presence: true
  validates :created_at, presence: true

  has_many :origin_characters, class_name: "Character", foreign_key: "origin_location_id"
  has_many :characters, class_name: "Character", foreign_key: "location_id"
end
