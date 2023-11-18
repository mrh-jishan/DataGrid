class CreateCsvRows < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_rows do |t|
      t.references :file_upload
      t.jsonb :csv_row, null: false, default: {}
      t.string :unique_by, array: true, default: []
      t.timestamps
    end

    add_index :csv_rows, [:file_upload_id, :csv_row, :unique_by], :unique => true
  end
end
