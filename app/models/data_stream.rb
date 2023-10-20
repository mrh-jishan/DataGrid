class DataStream < ApplicationRecord
  belongs_to :user

  validates :label, :presence => true
end
