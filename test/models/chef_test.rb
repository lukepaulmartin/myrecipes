require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(name: "john", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "name should be present" do
    @chef.name = ""
    assert_not @chef.valid?
  end
  
  test "name should not be too long" do
    @chef.name = "a" * 41
    assert_not @chef.valid?
  end
  
  test "name should not be too short" do
    @chef.name = "aa"
    assert_not @chef.valid?
  end
  
  test "email must be present" do
    @chef.email = ""
    assert_not @chef.valid? 
  end
  
  test "email should not be too long" do
    @chef.email = "a" * 101
    assert_not @chef.valid?
  end
  
  test "email should not be too short" do
    @chef.email = "a" * 6
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid? 
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.org R_TDD-DS@eee.hello.org user@example.com first.last@eee.au lara.joey@bank.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, "#{va.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_att_eee.org user.name@example. eee@i_e_.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, "#{ia.inspect} should be invalid"
    end
  end
end