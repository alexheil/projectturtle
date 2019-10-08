class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  attr_accessor :login

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9]+\Z/i }
  validate :validate_username

  has_one :profile, dependent: :destroy

  has_many :matches, through: :match_relationships #after joing match
  has_many :match_relationships, through: :participants #to join match
  has_many :match_outcomes, through: :participants #if user wins a match
  has_many :participants, dependent: :destroy #to join league

  has_many :match_votes, dependent: :destroy

  has_many :leagues #as owner
  belongs_to :league, optional: true #as participants

  before_save :should_generate_new_friendly_id?, if: :username_changed?
  before_save :downcase_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def joined?(league)
    Participant.exists? user_id: id, league_id: league.id
  end

  def unjoin(league)
    Participant.find_by(user_id: id, league_id: league.id).destroy
  end

  def join_id(league)
    Participant.find_by(user_id: id, league_id: league.id).id
  end

  def wins
    self.match_outcomes.count
  end

  def losses
    self.matches.count - self.match_outcomes.count
  end

  private

    def should_generate_new_friendly_id?
      username_changed?
    end

    def downcase_username
      self.username = username.downcase
    end

end
