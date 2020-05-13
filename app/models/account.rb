class Account < ActiveRecord::Base
    belongs_to :owner
    has_one :password
  
    def slug
      slug_name = self.name.gsub(/[^a-zA-Z0-9]/,'-').downcase
    end
  
    def self.find_by_slug(slug)
      Account.all.find {|a| a.slug === slug}
    end
  
  end