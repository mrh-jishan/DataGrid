class AddUniqByOnCsvRow < ActiveRecord::Migration[7.0]
  def change
    add_column :csv_rows, :unique_by, :string, array: true, default: []
  end
end
