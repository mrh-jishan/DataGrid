class DataStreamFile < ApplicationRecord

  mount_uploader :file, CsvFileUploader

  belongs_to :data_stream
end
