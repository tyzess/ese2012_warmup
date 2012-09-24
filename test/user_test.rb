require 'test/unit'
require '../app/traders/user'
require '../app/traders/item'

class UserTest < Test::Unit::TestCase

  def test_construction
    user = Traders::User.create("Hans")
    assert_equal(user.name, "Hans")
    assert_equal(user.credits, 100)
    assert_equal(user.items.length, 0)
  end

  def test_item_list
    user = Traders::User.create("Lotti")
    item1 = Traders::Item.create_active("Odlid",22)
    item2 = Traders::Item.create("Racletteofen",11)
    item3 = Traders::Item.create("Nintendo64",11)

    assert_equal(user.items.length, 0)
    assert_equal(user.list_items, "")
    assert_equal(user.all_items, [])
    assert_equal(user.all_items_for_sell, [])
    assert_equal(user.list_items_to_sell, "")

    user.add_item(item1)
    user.add_item(item2)
    assert_equal(user.items.length, 2)
    assert_equal(user.list_items, "Odlid\nRacletteofen\n")
    assert_equal(user.all_items, [item1, item2])
    assert_equal(user.all_items_for_sell, [item1])
    assert_equal(user.list_items_to_sell, "Odlid\n")

    user.add_item(item3)
    assert_equal(user.items.length, 3)
    assert_equal(user.list_items, "Odlid\nRacletteofen\nNintendo64\n")
    assert_equal(user.all_items, [item1, item2, item3])
    assert_equal(user.all_items_for_sell, [item1])
    assert_equal(user.list_items_to_sell, "Odlid\n")

    user.remove_item(item1)
    assert_equal(user.items.length, 2)
    assert_equal(user.list_items, "Racletteofen\nNintendo64\n")
    assert_equal(user.all_items, [item2, item3])
    assert_equal(user.all_items_for_sell, [])
    assert_equal(user.list_items_to_sell, "")
  end

  def test_buy_item_from_user
    buyer = Traders::User.create("Germany")
    seller = Traders::User.create("Anonymous")
    item1 = Traders::Item.create("SteuerCD",99)
    item2 = Traders::Item.create("Racletteofen",29.95)
    seller.add_item(item1)
    seller.add_item(item2)

    assert_equal(seller.credits, 100)
    assert_equal(seller.items.length, 2)
    assert_equal(buyer.credits, 100)
    assert_equal(buyer.items.length, 0)

    assert(buyer.buy_item(item1) == false, "try's to buy, but item is not active yet")

    assert_equal(seller.credits, 100)
    assert_equal(seller.items.length, 2)
    assert_equal(buyer.credits, 100)
    assert_equal(buyer.items.length, 0)

    item1.active = true
    buyer.take_credits(2)
    assert(buyer.buy_item(item1) == false, "try's to buy, but doesn't have enough credits")

    assert_equal(seller.credits, 100)
    assert_equal(seller.items.length, 2)
    assert_equal(buyer.credits, 98)
    assert_equal(buyer.items.length, 0)

    item1.active = true
    buyer.give_credits(22)
    assert(buyer.buy_item(item1) == true, "buy's it")

    assert_equal(seller.credits, 199)
    assert_equal(seller.items.length, 1)
    assert_equal(buyer.credits, 21)
    assert_equal(buyer.items.length, 1)
  end

end