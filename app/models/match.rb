class Match < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :week

  belongs_to :participant_one, class_name: "Participant"
  belongs_to :participant_two, class_name: "Participant"

  validates :participant_one_id, presence: true
  validates :participant_two_id, presence: true

  validates :title, presence: true, length: { maximum: 100 }
  #validates :description, presence: true, length: { maximum: 1000 }
  #validates :image, presence: true

  before_save :should_generate_new_friendly_id?, if: :title_changed?
  
  private

    def should_generate_new_friendly_id?
      title_changed?
    end
end
