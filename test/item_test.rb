require 'test/unit'
require '../app/traders/item'

class Item_Test    < Test::Unit::TestCase

   def test_construction
     item1 = Traders::Item.create("Pen", 1)
     item2 = Traders::Item.create("Dildo",45.95)

     assert_equal(item1.name, "Pen")
     assert_equal(item1.price, 1.0)
     assert_equal(item1.active, false)
     assert_equal(item1.owner, nil)

     assert_equal(item2.name, "Dildo")
     assert_equal(item2.price, 45.95)
     assert_equal(item2.active, false)
     assert_equal(item2.owner, nil)
   end

end