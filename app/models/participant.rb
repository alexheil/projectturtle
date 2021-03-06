class Participant < ApplicationRecord

  belongs_to :user
  belongs_to :league

  has_many :match_relationships, dependent: :destroy

  has_many :match_votes, dependent: :destroy

  has_many :match_outcomes

  validates :user_id, presence: true
  validates :league_id, presence: true

  def match_vote_id(match)
    MatchVote.where(participant_id: id, match_id: match.id)
  end

  def league_match_outcome(league)
    MatchOutcome.where(participant_id: id, league_id: league.id)
  end

  def league_match_count(league)
    MatchRelationship.where(participant_id: id, league_id: league.id)
  end

  def wins
    self.league_match_outcome(league).count
  end

  def losses
    self.league_match_count(league).count - self.league_match_outcome(league).count
  end

end
