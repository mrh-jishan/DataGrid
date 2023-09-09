class CreateAggregations < ActiveRecord::Migration[7.0]
  def change
    create_table :aggregations do |t|
      t.references :visualization
      t.references :csv_header
      t.string :axis
      t.string :aggregate_function
      t.timestamps
    end
  end
end
