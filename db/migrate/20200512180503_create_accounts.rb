class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :password_content
      t.string :name
      t.integer :owner_id
    end
  end
end
