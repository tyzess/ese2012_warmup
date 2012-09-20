module Traders

  class Item
    attr_accessor :name , :price , :active , :owner

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

  end
end