class CsvRow < ApplicationRecord
  belongs_to :file_upload
  has_many :csv_headers, :through => :file_upload

  scope :select_columns, ->(column_names) {
    select(column_names.map { |column_name| "csv_row->>'#{column_name}' AS #{column_name.parameterize.underscore}" }.join(', '))
  }

  scope :group_by_columns, ->(column_names) {
    group(column_names.map { |column_name| column_name.parameterize.underscore }.join(', '))
  }

end
