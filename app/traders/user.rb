module Traders

  class User

    attr_accessor :name , :credits, :items

    # default constructor
    def self.create(name)
      user = self.new
      user.name = name
      user
    end

    def initialize
      self.credits = 100
      self.items = Array.new
    end

    # adds item to user and sets items owner to user
    def add_item(item)
      items.push(item)
      item.owner = self
    end

    # removes item from user and leaves it unowned
    def remove_item(item)
      items.delete(item)
      item.owner = nil
    end

    # buys chosen item if its active and user has enough credits
    # credits will be transferred to previous owner ot the item
    def buy_item(item)
      if !item.active || item.price > self.credits
        false
      else
        seller = item.owner
        price = item.price

        seller.give_credits(price)
        self.take_credits(price)
        seller.remove_item(item)
        self.add_item(item)
        item.active = false
        true
      end
    end

    # adds credits to user
    def give_credits(credits)
      self.credits = self.credits + credits
    end

    # removes credits to user
    # if credits are too low, credits won't be removed
    def take_credits(credits)
      if self.credits < credits
        false
      else
        self.credits = self.credits - credits
        true
      end
    end

    # returns all items owned by user
    def all_items
      list = Array.new
      items.each{ |item| list.push(item)}
      list
    end

    # returns all items owned by user that can be sold
    def all_items_for_sell
      list = Array.new
      items.each{ |item|
        if item.active == true
          list.push(item)
        end}
      list
    end

    # lists all item names owned by user
    def list_items
      list = ""
      items.each{ |item| list = list + item.name + "\n"}
      list
    end

    # lists all item names owned by user that can be sold
    def list_items_to_sell
      list = ""
      items.each{ |item|
        if item.active == true
          list = list + item.name + "\n"
        end}
      list
    end

    def to_s
      "Name: #{name} Credits:#{self.credits} Items:#{self.list_items}"
    end

  end
end