class CsvRow < ApplicationRecord
  belongs_to :file_upload
  has_many :csv_headers, :through => :file_upload
end
