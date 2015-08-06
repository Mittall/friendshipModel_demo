class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_last, :string
    add_column :users, :contact, :integer
  end
end
