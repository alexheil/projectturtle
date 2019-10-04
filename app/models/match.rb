class Match < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  belongs_to :week

  has_many :match_relationships, dependent: :destroy
  has_many :participants, through: :match_relationships 

  has_many :match_votes, dependent: :destroy, before_add: :validate_vote_limit

  has_one :match_outcome

  NUMBER_OF_PERMITTED_VOTES = 3

  validates :week_id, presence: true

  before_save :generated_slug
  
  private

    def generated_slug
      require 'securerandom' 
      self.slug = SecureRandom.hex(16) if slug.blank?
    end

    def validate_vote_limit(match_vote)
      raise Exception.new if match_votes.size >= NUMBER_OF_PERMITTED_VOTES
    end


end
