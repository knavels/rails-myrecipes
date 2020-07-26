require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: 'Navid', email: "dezashibi@gmail.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "name should be peresent" do
    @chef_test = Chef.new(chefname: '', email: "dezashibi@gmail.com")
    assert_not @chef_test.valid?
  end

  test "name should be less than 30 characters" do
    @chef_test = Chef.new(chefname: 'a' * 31, email: "dezashibi@gmail.com")
    assert_not @chef_test.valid?
  end

  test "email should be peresent" do
    @chef_test = Chef.new(chefname: 'Navid', email: "")
    assert_not @chef_test.valid?
  end

  test "email should not be too long" do
    @chef_test = Chef.new(chefname: 'Navid', email: "a" * 250 + "@example.com")
    assert_not @chef_test.valid?
  end

  test "email should accepts correct format" do
    valid_emails = %w[user@email.com navid@dezashibi.com navid+dezashibi@yahoo.co.uk]

    valid_emails.each do |valid|
      @chef_test = Chef.new(chefname: 'Navid', email: valid)
      assert @chef_test.valid?, "#{valid.inspect} should be valid"
    end
  end

  test "email should rejects incorrect format" do
    invalid_emails = %w[user@email @dezashibi.com +dezashibi@yahoo.]

    invalid_emails.each do |invalid|
      @chef_test = Chef.new(chefname: 'Navid', email: invalid)
      assert_not @chef_test.valid?, "#{invalid.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_chef = @chef.dup
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lowercase before save in db" do
    mixed_email = "NAVID@DEZASHIBI.COM"
    @chef.email = mixed_email
    @chef.save

    assert_equal mixed_email.downcase, @chef.reload.email
  end
end