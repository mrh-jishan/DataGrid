class DataPlatform < ApplicationRecord

  belongs_to :platform
  belongs_to :user

  validates :platform_id, :config, :presence => true

end
