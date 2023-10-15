class CreatePlatforms < ActiveRecord::Migration[7.0]
  def change
    create_table :platforms do |t|
      t.string :label
      t.timestamps
    end
  end
end


# t.references :data_platform
# t.references :platform
# t.string :config