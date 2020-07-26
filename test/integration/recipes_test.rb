require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: 'Navid', email: "dezashibi@gmail.com")

    @recipe = Recipe.create!(name: "Vegitable", description: "Greate vegi recipe", chef: @chef)
    @recipe2 = @chef.recipes.create!(name: "Meat", description: "Greate Meaty recipe")
  end
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
