class Dataset < ApplicationRecord

  mount_uploader :file, CsvFileUploader

  belongs_to :user
  has_many :csv_headers, :dependent => :destroy
  has_many :csv_rows, :dependent => :delete_all # no dependent table
  has_many :visualizations, :dependent => :destroy
  has_many :aggregators, :through => :visualizations, :dependent => :destroy
  has_many :data_streams, :dependent => :destroy

  before_save :extract_metadata

  validates :unique_by, :file, :presence => true, exclusion: { in: [nil, ""], message: "can't be blank" }
  validates :name, :presence => true, :uniqueness => { :case_sensitive => true, scope: :user }

  def to_s
    name
  end

  private

  def extract_metadata
    if self.file.present?
      # self.name = File.basename(self.file.path)
      self.file_type = self.file.content_type
      self.file_size = self.file.size
    end
  end

end
