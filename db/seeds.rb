require 'pry'
require 'csv'
require 'postgres-copy'


#translate the names to ids for our relationship
def assign_advertiser(name)
  case name
  when "Coca Cola"
    return 1
  when "Lenovo"
    return 2
  when "Best Buy"
    return 3
  when "Apple"
    return 4
  when "Acer"
    return 5
  when "Logitech"
    return 6
  when "Staples"
    return 7
  when "Motorola"
    return 8
  when "Holmes"
    return 9
  when "Nike"
    return 10
  end


end

# seed the advertisers, using the same logic as above
advertisers = ['Coca Cola', 'Lenovo', 'Best Buy', 'Apple', 'Acer', 'Logitech', "Staples", 'Motorola', 'Holmes', 'Nike']
advertisers.each do |company|
  # binding.pry
  Advertiser.create(name: company)
end

#takes a VERY long time, around 3-4 minutes for ~55k records. no good.
# CSV.foreach("./db/seeds/products.csv") do |row|
#   Product.create(product_name: row[0], product_sku: row[1], advertiser_id: assign_advertiser(row[2]), advertiser_name: row[3])
# end


# the standard way of importing csv records, with rails built in CSV.parse
# this also takes too long
# products = File.read("./db/seeds/products.csv")
# products = CSV.parse(products)
#
# products.each do |product|
#   # binding.pry
#   Product.create(product_name: product[0], product_sku: product[1], advertiser_id: assign_advertiser(product[2]), advertiser_name: product[2])
# end

# generic copy to the pg database. we need a way to execute assigning the products to the advertisers...
# Product.copy_from "./db/seeds/products.csv"


# so we added an extra column to the database, a duplicate of advertisers names,
# and use our method to translate the id, thereby assuring the relation works

Product.copy_from "./db/seeds/products.csv" do |row|
  row[3] = assign_advertiser(row[3])
end
