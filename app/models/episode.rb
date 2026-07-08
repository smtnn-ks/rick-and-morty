class Episode < ApplicationRecord
  validates :name, presence: true
  validates :air_date, presence: true
  validates :code, presence: true
  validates :created_at, presence: true

  has_and_belongs_to_many :characters
end
