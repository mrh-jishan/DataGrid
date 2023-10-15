class CreateDataPlatforms < ActiveRecord::Migration[7.0]
  def change
    create_table :data_platforms do |t|
      t.references :user
      t.references :platform
      t.jsonb :config
      t.timestamps
    end
  end
end
