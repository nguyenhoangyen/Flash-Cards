require 'test_helper'
require 'digest/sha2'

class UserTest < ActiveSupport::TestCase
  
  test "should allow valid email addresses" do
    user1 = User.create( :email => "noah@test.com", :password => "secret" )
    assert_equal 3, User.count
  end
  
  test "should have a reg_hash" do
    user1 = User.create( :email => "noah@test.com", :password => "secret" )
    assert_equal Digest::SHA256.hexdigest( user1.email + user1.id.to_s ), user1.reg_hash
  end
  
end
