class MatchRelationship < ApplicationRecord

  belongs_to :participant
  belongs_to :match

  validates :participant_id, presence: true
  validates :match_id, presence: true

end
