class Visualization < ApplicationRecord
  belongs_to :file_upload
  has_many :aggregations

end
