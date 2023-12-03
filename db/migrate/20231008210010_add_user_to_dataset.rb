class AddUserToDataset < ActiveRecord::Migration[7.0]
  def change
    add_reference :datasets, :user, :index => true
  end
end
