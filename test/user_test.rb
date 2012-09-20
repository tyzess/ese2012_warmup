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
    item1 = Traders::Item.create("Dildo",22)
    item2 = Traders::Item.create("Racletteofen",11)
    user.add_item(item1)
    user.add_item(item2)
    assert_equal(user.items.length, 2)
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

    # try's to buy, but item is not active yet
    buyer.buy_item(item1)

    assert_equal(seller.credits, 100)
    assert_equal(seller.items.length, 2)

    assert_equal(buyer.credits, 100)
    assert_equal(buyer.items.length, 0)

    # try's to buy, but doesn't have enough credits
    item1.active = true
    buyer.credits = 98
    buyer.buy_item(item1)

    assert_equal(seller.credits, 100)
    assert_equal(seller.items.length, 2)

    assert_equal(buyer.credits, 98)
    assert_equal(buyer.items.length, 0)

    # buy's it :(
    item1.active = true
    buyer.credits = 120
    buyer.buy_item(item1)

    assert_equal(seller.credits, 199)
    assert_equal(seller.items.length, 1)

    assert_equal(buyer.credits, 21)
    assert_equal(buyer.items.length, 1)
  end

end