class CreateDataStreamFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :data_stream_files do |t|
      t.references :data_stream
      t.string :file
      t.timestamps
    end
  end
end
