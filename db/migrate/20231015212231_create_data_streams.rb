class CreateDataStreams < ActiveRecord::Migration[7.0]
  def change
    create_table :data_streams do |t|
      t.references :user
      t.string :label
      t.string :unique_by, array: true, default: []
      t.timestamps
    end
  end
end
