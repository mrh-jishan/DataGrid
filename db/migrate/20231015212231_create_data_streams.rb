class CreateDataStreams < ActiveRecord::Migration[7.0]
  def change
    create_table :data_streams do |t|
      t.references :user
      t.references :dataset
      t.timestamps
    end
  end
end
