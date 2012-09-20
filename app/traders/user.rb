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

    def add_item(item)
      items.push(item)
      item.owner = self
    end

    def remove_item(item)
      items.delete(item)
      item.owner = nil
    end

    def buy_item(item)
      if !item.active || item.price > self.credits
        false
      else
        seller = item.owner
        price = item.price

        self.take_credits(price)
        seller.give_credits(price)
        seller.remove_item(item)
        self.add_item(item)
        item.owner = self
        item.active = false
        true
      end
    end

    def give_credits(credits)
      self.credits = self.credits + credits
    end

    def take_credits(credits)
      self.credits = self.credits - credits
    end

    def list_items
      list = "Items: \n"
      items.each{ |item| list = list + item.name + "\n"}
      list
    end

  end
end