class CsvHeader < ApplicationRecord

  default_scope { order(name: :asc) }

  belongs_to :file_upload

  def to_s
    name.parameterize.underscore
  end

end
