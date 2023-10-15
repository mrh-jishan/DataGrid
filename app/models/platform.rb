class Platform < ApplicationRecord

  has_and_belongs_to_many :data_platforms

  def to_s
    label
  end
end
