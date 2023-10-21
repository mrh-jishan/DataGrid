class Platform < ApplicationRecord

  has_many :data_platforms, :dependent => :destroy


  validates :label, :presence => true

  def to_s
    label
  end
end
