require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(name: "Vegitable", description: "Greate vegi recipe")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @test_recipe = Recipe.new(name: "", description: "My Description")
    assert_not @test_recipe.valid?
  end

  test "description should be present" do
    @test_recipe = Recipe.new(name: "title", description: "")
    assert_not @test_recipe.valid?
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