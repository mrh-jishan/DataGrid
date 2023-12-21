class ShortUrl < ApplicationRecord

  belongs_to :shareable, polymorphic: true
  has_many :short_url_views, dependent: :destroy

end
