class CreateAggregators < ActiveRecord::Migration[7.0]
  def change
    create_table :aggregators do |t|
      t.references :visualization
      t.references :csv_header
      t.string :axis
      t.string :aggregator_function
      t.timestamps
    end

    add_index :aggregators, [:visualization_id, :csv_header_id, :aggregator_function, :axis], :unique => true, :name => 'idx_viz_header_function_axis'
  end
end
