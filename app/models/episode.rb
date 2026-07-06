class Episode < ApplicationRecord
  validates :name, presence: true
  validates :air_date, presence: true
  validates :episode_code, presence: true

  has_and_belongs_to_many :characters
end
