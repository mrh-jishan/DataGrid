class CreateShortUrlViews < ActiveRecord::Migration[7.0]
  def change
    create_table :short_url_views do |t|
      t.references :link
      t.string :user_agent
      t.string :ip

      t.timestamps
    end
  end
end
