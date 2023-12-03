class AddDatasetNameToDataset < ActiveRecord::Migration[7.0]
  def change
    add_column :datasets, :dataset_name, :string
  end
end
