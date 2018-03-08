class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_sku
      t.integer :advertiser_id


      t.timestamps
    end
  end
end
