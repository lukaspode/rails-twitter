class AddNewFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :website, :string
  end
end
