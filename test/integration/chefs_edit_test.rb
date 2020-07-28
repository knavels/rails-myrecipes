require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: 'Navid',
                         email: "dezashibi@gmail.com",
                         password: "password",
                         password_confirmation: "password")
  end

  test "reject and invalid edit chef data" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    assert_no_difference 'Chef.count' do
      patch chef_path(@chef), params: { chef: { chefname: "", email: "" }}
    end
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid edit chef data" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "updated name", email: "updated@email.com" }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "updated name", @chef.chefname
    assert_match "updated@email.com", @chef.email
  end
end
