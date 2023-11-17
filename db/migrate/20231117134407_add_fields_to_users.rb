class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :birth, :date
  end
end
