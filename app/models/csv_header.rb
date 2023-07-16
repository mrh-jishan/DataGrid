class CsvHeader < ApplicationRecord

  belongs_to :file_upload

  def to_s
    name.parameterize.underscore
  end

end
