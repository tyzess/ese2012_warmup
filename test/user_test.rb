require 'test/unit'
require '../app/traders/user'

class UserTest < Test::Unit::TestCase

  def test_credits
    user = Traders::User.create("Hans")
    assert(user.credits, 100)
  end

end