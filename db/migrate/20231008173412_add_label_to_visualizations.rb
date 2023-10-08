class AddLabelToVisualizations < ActiveRecord::Migration[7.0]
  def change
    add_column :visualizations, :label, :string
  end
end
