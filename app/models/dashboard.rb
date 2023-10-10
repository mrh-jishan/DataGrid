class Dashboard < ApplicationRecord
  has_and_belongs_to_many :visualizations

  validates :label, :presence => true
end
