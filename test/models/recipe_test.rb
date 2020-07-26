require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "Navid", email: "dezashibi@gmail.com")
    @recipe = @chef.recipes.build(name: "Vegitable", description: "Greate vegi recipe")
  end

  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = nil
    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = nil
    assert_not @recipe.valid?
  end

  test "description should not be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end

  test "description should not be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
end