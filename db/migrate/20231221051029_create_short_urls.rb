class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.references :shareable, polymorphic: true
      t.string :shared_url
      t.string :original_url
      t.datetime :expires_at
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
