class Product < ApplicationRecord
  validates :product_sku, uniqueness: true
  belongs_to :advertiser
  acts_as_copy_target

end
