class Participant < ApplicationRecord

  belongs_to :user
  belongs_to :league

  has_many :match_relationships, dependent: :destroy

  has_many :match_votes, dependent: :destroy

  validates :user_id, presence: true
  validates :league_id, presence: true

end
