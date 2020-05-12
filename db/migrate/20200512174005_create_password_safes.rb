class CreatePasswordSafes < ActiveRecord::Migration[5.2]
  def change :password_safe do |t|
    t.integer :account_id
    t.integer :password_id
    end 
  end
end
