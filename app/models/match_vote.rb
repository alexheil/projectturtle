class MatchVote < ApplicationRecord

  has_one :match_proof, dependent: :destroy

  belongs_to :participant
  belongs_to :match
  belongs_to :user

  validates :participant_id, presence: true
  validates :match_id, presence: true
  validates :user_id, presence: true

end
