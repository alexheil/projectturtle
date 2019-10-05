class League < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :game, optional: true
  belongs_to :playlist

  has_many :match_relationships
  has_many :participants
  has_many :users, through: :participants

  has_many :weeks, dependent: :destroy
  has_many :matches, through: :weeks
  has_many :match_outcomes

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
