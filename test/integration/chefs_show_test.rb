require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: 'Navid',
                         email: "dezashibi@gmail.com",
                         password: "password",
                         password_confirmation: "password")

    @recipe = Recipe.create!(name: "Vegitable", description: "Greate vegi recipe", chef: @chef)
    @recipe2 = @chef.recipes.create!(name: "Meat", description: "Greate Meaty recipe")
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template "chefs/show"
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @chef.chefname, response.body
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @recipe2.name, response.body
    assert_match @recipe2.description, response.body
  end
end
