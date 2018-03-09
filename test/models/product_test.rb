require 'test_helper'



class ProductTest < ActiveSupport::TestCase
  test "should not save product without attributes" do
    product = Product.new
    assert_not product.save
  end

  test "should not save product without advertiser" do
    product = Product.new(product_name: "Television", product_sku: "this is my sku")
    assert_not product.save
  end

  test "should save when created completely" do
    advert = Advertiser.create(name: "Big Advertising")
    product =  Product.new(product_name: "Television", product_sku: "this is my sku")
    product.advertiser = advert
    assert_equal product.advertiser.name, advert.name
  end

end
