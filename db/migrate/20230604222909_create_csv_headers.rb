class CreateCsvHeaders < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_headers do |t|
      t.references :dataset
      t.string :name
      t.timestamps
    end

    add_index :csv_headers, [:name, :dataset_id], :unique => true

  end
end
