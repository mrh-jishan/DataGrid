class ShortUrl < ApplicationRecord

  belongs_to :shareable, polymorphic: true

  validates :slug, :presence => true, :uniqueness => { :case_sensitive => true }
  validates :expires_at, :presence => true
  before_validation { self.slug = SecureRandom.uuid if slug.nil? || slug.empty? }

  def short_code
    ShortCode.encode(slug)
  end

  def expired?
    expires_at.present? && expires_at < Time.now
  end

end
