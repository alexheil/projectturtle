class MatchVote < ApplicationRecord

  belongs_to :participant
  belongs_to :match
  belongs_to :user

  validates :participant_id, presence: true
  validates :match_id, presence: true
  validates :user_id, presence: true

  def self.check_match_votes
    if participant.match_vote_id(match).count >= 2
      participant.match_vote_id(match).count
    end
  end

end
