class Participant < ApplicationRecord

  belongs_to :user
  belongs_to :league

  has_many :matches
  has_many :away_matches, class_name: "Match", foreign_key: "participant_one_id", dependent: :destroy
  has_many :home_matches, class_name: "Match", foreign_key: "participant_two_id", dependent: :destroy

  validates :user_id, presence: true
  validates :league_id, presence: true

end
