class CreateVisualizations < ActiveRecord::Migration[7.0]
  def change
    create_table :visualizations do |t|
      t.references :dataset
      t.string :chart_type
      t.timestamps
    end
  end
end
