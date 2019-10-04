class Match < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :week

  has_many :match_relationships, dependent: :destroy 

  has_many :match_votes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  #validates :description, presence: true, length: { maximum: 1000 }
  #validates :image, presence: true

  before_save :should_generate_new_friendly_id?, if: :title_changed?
  
  private

    def should_generate_new_friendly_id?
      title_changed?
    end
end
