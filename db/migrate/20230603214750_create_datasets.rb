class CreateDatasets < ActiveRecord::Migration[7.0]
  def change
    create_table :datasets do |t|
      t.string :name
      t.string :file
      t.string :file_type
      t.bigint :file_size
      t.string :unique_by, array: true, default: []
      t.timestamps
    end

  end
end
