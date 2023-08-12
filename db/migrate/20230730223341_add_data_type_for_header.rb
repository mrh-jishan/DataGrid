class AddDataTypeForHeader < ActiveRecord::Migration[7.0]
  def change
    add_column :csv_headers, :data_type, :string, :null => false, :default => :string
  end
end
