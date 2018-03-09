class Product < ApplicationRecord
  validates :product_sku, uniqueness: true
  belongs_to :advertiser

end
