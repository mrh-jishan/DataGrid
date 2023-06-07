class CreateFileUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :file_uploads do |t|
      t.string :name
      t.string :file
      t.string :file_type
      t.bigint :file_size

      t.timestamps
    end
  end
end
