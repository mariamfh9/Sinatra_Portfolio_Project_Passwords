class CreatePsswords < ActiveRecord::Migration
  def change
    create_table :psswords do |t|
      t.string :password_value
      t.integer :account_id
    end
  end
end
