module Traders

  class User
    attr_accessor :name , :credits, :items

    def self.create(name)
      user = self.new
      user.name = name
      user
    end

    def initialize
      self.credits = 100
      self.items = Array.new
    end

  end
end