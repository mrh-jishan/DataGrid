class Dashboard < ApplicationRecord

  has_and_belongs_to_many :visualizations
  has_many :short_urls, as: :shareable, :dependent => :destroy
  # has_many :shared_dashboards

  validates :label, :presence => true
  validates :visualizations, :presence => true

  def to_s
    label
  end
end
