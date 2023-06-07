class CreateCsvHeaders < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_headers do |t|
      t.references :file_upload
      t.string :name
      t.timestamps
    end
  end
end
