class CreateVisualizations < ActiveRecord::Migration[7.0]
  def change
    create_table :visualizations do |t|
      t.references :file_upload
      t.string :chart_type
      t.timestamps
    end
  end
end
