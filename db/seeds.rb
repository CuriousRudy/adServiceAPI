require 'pry'
require 'csv'

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

advertisers = ['Coca Cola', 'Lenovo', 'Best Buy', 'Apple', 'Acer', 'Logitech', "Staples", 'Motorola', 'Holmes', 'Nike']
advertisers.each do |company|
  # binding.pry
  Advertiser.create(name: company)
end



products = File.read("./db/seeds/products.csv")
products = CSV.parse(products)

products.each do |product|
  # binding.pry
  Product.create(product_name: product[0], product_sku: product[1], advertiser_id: assign_advertiser(product[2]), advertiser_name: product[2])
end
