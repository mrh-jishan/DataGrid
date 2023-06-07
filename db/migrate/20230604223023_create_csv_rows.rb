class CreateCsvRows < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_rows do |t|
      t.references :file_upload
      t.jsonb :csv_row, null: false, default: {}
      t.timestamps
    end

    add_index :csv_rows, [:csv_row, :file_upload_id], :unique => true
  end
end
