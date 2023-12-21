class SharedDashboard < ApplicationRecord
  belongs_to :dashboard

  validates :expires_at, :presence => true
end
