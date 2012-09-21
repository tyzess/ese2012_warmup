module Traders

  class Item

    attr_accessor :name , :price , :active , :owner

    # default constructor
    def self.create(name, price)
      item = self.new
      item.name = name
      item.price = price
      item
    end

    def initialize
      self.active = false
      self.owner = nil
    end

    # constructor to create active items
    def self.create_active(name, price)
      item = self.create(name, price)
      item.active = true
      item
    end

  end

end