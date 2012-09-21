require 'test/unit'
require '../app/traders/item'

class Item_Test < Test::Unit::TestCase

   def test_construction
     item1 = Traders::Item.create("Pen", 1)
     item2 = Traders::Item.create("Stock",45.95)
     item3 = Traders::Item.create_active("Stock",45.95)
     item4 = Traders::Item.create_active("Spam", 2)

     assert_equal(item1.name, "Pen")
     assert_equal(item1.price, 1.0)
     assert_equal(item1.active, false)
     assert_equal(item1.owner, nil)

     assert_equal(item2.name, "Stock")
     assert_equal(item2.price, 45.95)
     assert_equal(item2.active, false)
     assert_equal(item2.owner, nil)

     assert_equal(item3.name, "Stock")
     assert_equal(item3.price, 45.95)
     assert_equal(item3.active, true)
     assert_equal(item3.owner, nil)

     assert_equal(item4.name, "Spam")
     assert_equal(item4.price, 2)
     assert_equal(item4.active, true)
     assert_equal(item4.owner, nil)
   end

end