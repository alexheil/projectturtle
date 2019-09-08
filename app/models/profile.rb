class Profile < ApplicationRecord
  # include ImageUploader[:image]

  validates :first_name, format: { with: /\A[-a-z]+\z/i }, allow_blank: true
  validates :last_name, format: { with: /\A[-a-z]+\z/i }, allow_blank: true
  validates :biography, length: { maximum: 4000 }, allow_blank: true
  validates :website, format: { with: /\A((http|https)?:\/\/)?(www.)?[a-zA-Z0-9]+.[a-z]+\/?/i }, allow_blank: true
  
  belongs_to :user

  before_save :smart_add_url_protocol
  before_save :downcase

  private

    def smart_add_url_protocol
      unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
        self.website = "https://#{self.website}" unless website.blank?
      end
    end

    def downcase
      self.website = website.downcase if self.website.present?
    end
end
