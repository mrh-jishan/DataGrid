class AddUserToFileUpload < ActiveRecord::Migration[7.0]
  def change
    add_reference :file_uploads, :user, :index => true
  end
end
