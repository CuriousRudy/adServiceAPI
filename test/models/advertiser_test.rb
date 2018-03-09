require 'test_helper'

class AdvertiserTest < ActiveSupport::TestCase

    test "should not save advertiser without name" do
      advertiser = Advertiser.new
      assert_not advertiser.save
    end

    test "advertiser names are unique" do
      advertiser = Advertiser.create(name: "Big advertising")
      advertiser_2 = Advertiser.new(name: "Big advertising")
      assert_not advertiser_2.save
    end

end
