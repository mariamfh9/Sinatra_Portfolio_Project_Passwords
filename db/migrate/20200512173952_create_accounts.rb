class CreateAccounts < ActiveRecord::Migration[5.2]
  def change :accounts do |t|
    t.string :name
  end
  end
end
