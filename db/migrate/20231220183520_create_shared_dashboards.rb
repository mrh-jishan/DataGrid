class CreateSharedDashboards < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_dashboards do |t|
      t.references :dashboard
      t.datetime :expires_at
      t.timestamps
    end
  end
end
