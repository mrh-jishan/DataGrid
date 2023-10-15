class Platform < ApplicationRecord

  has_many :data_platforms, :dependent => :destroy

  def to_s
    label
  end
end
