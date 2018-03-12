class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_sku
      t.integer :advertiser_id
      t.string :advertiser_name
    end
  end
end
