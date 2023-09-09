class AddDataTypeForHeader < ActiveRecord::Migration[7.0]
  def change
    add_column :csv_headers, :aggregate_function, :string, :null => false, :default => :count
  end
end
