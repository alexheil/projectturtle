class MatchProof < ApplicationRecord

  include ImageUploader[:image]

  belongs_to :match
  belongs_to :match_vote

end
