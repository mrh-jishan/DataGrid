class AddUniqByOnFileUpload < ActiveRecord::Migration[7.0]
  def change
    add_column :file_uploads, :unique_by, :string, array: true, default: []
  end
end
