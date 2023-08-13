class CsvRow < ApplicationRecord
  belongs_to :file_upload
  has_many :csv_headers, :through => :file_upload

  scope :select_columns, -> (column_names) {
    column_names.map { |column_name, aggregate_function|
      select_column(column_name, aggregate_function)
    }.reduce(:merge)
  }

  scope :select_column, ->(column_name, aggregate_function = nil) {
    if aggregate_function
      case aggregate_function
      when "min", "max", "sum", "avg"
        select("#{aggregate_function}(CAST(csv_row->>'#{column_name}' AS NUMERIC)) AS #{column_name.parameterize.underscore}_#{aggregate_function}")
      else
        select("#{aggregate_function}(csv_row->>'#{column_name}') AS #{column_name.parameterize.underscore}_#{aggregate_function}")
      end
    else
      select("csv_row->>'#{column_name}' AS #{column_name.parameterize.underscore}")
    end
  }

  scope :group_by_column_name, ->(column_name) {
    select_column(column_name).group("csv_row->>'#{column_name}'")
  }

  scope :group_by_column_names, ->(column_names) {
    column_names.map { |column_name, aggregate_function|
      select_column(column_name, aggregate_function).select_column(column_name).group("csv_row->>'#{column_name}'")
    }.reduce(:merge)
  }

end
