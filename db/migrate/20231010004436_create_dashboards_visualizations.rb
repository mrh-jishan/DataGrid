class CreateDashboardsVisualizations < ActiveRecord::Migration[7.0]
  def change
    create_table :dashboards_visualizations do |t|
      t.references :dashboard
      t.references :visualization
      t.timestamps
    end
  end
end
