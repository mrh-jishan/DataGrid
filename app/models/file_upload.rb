class FileUpload < ApplicationRecord

  mount_uploader :file, CsvFileUploader

  has_many :csv_headers
  has_many :csv_rows
  has_many :visualizations
  has_many :aggregators, :through => :visualizations

  before_save :extract_metadata

  def extract_metadata
    if self.file.present?
      self.name = File.basename(self.file.path)
      self.file_type = self.file.content_type
      self.file_size = self.file.size
    end
  end

  def to_s
    name
  end

end
