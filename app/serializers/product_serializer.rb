class ProductSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :product_name, :product_sku, :advertiser_id, :advertiser_name
  belongs_to :advertiser



end
