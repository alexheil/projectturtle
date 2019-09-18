class League < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :game, optional: true
  belongs_to :playlist

  has_many :participants
  has_many :users, through: :participants

  validates :playlist_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  #validates :description, presence: true, length: { maximum: 1000 }
  #validates :image, presence: true

  before_save :should_generate_new_friendly_id?, if: :title_changed?
  
  private

    def should_generate_new_friendly_id?
      title_changed?
    end

end
