class Owner < ActiveRecord::Base
    has_many :accounts
    has_many :passwords, through: :accounts
    has_secure_password


    validates :username, :password, :presence => true
    validates :username, uniqueness: true
    def slug
      slug_name = self.name.gsub(/[^a-zA-Z0-9]/,'-').downcase
    end
  
    def self.find_by_slug(slug)
      Owner.all.find {|a| a.slug === slug}
    end
    
  
  end