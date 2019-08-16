class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accomodates, presence: true
  validates :bedroom, presence: true
  validates :bathroom, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true


  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
