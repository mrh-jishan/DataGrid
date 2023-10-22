class AddImportSourceOnDataStream < ActiveRecord::Migration[7.0]
  def change
    add_column :file_uploads, :import_source, :integer, :default => 1
  end
end
