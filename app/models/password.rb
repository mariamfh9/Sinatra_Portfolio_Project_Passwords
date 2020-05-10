class Password < ActiveRecord::Base
    belongs_to :owner
    belongs_to :account
  end