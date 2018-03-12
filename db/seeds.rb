require 'pry'
require 'csv'
# require 'postgres-copy'

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

# ////////
# seed the advertisers, using the same logic as above
advertisers = ['Coca Cola', 'Lenovo', 'Best Buy', 'Apple', 'Acer', 'Logitech', "Staples", 'Motorola', 'Holmes', 'Nike']
advertisers.each do |company|
  # binding.pry
  Advertiser.create(name: company)
end

#/////// UNCOMMENT FIRST AND RUN WITH FILE TO ADD UNIQUE ID
# add the id column to the csv, using our custom method. YOU MIGHT HAVE TO REMOVE THE QUOTES FROM THE HEADERS IN NEW_DATA.CSV
write_parameters = { write_headers: true, headers: %w(product_name,product_sku,advertiser_name,advertiser_id) }
read_parameters  = { encoding: 'UTF-8',
                     headers: true,
                     header_converters: :symbol,
                     converters: :all }

CSV.open('./db/seeds/new_data.csv', 'w+', write_parameters) do |new_csv|
  CSV.foreach('./db/seeds/products.csv', read_parameters) do |row|
    advertiser_id = assign_advertiser(row[:advertiser_name])
    row[:advertiser_id] = advertiser_id.to_i
    new_csv << row
  end
end


# COMMENT THIS OUT WHILE RUNNING THE SCRIPT FOR ADDING ID's
# CREATES A TEMP TABLE TO SPEED UP PG IMPORT FROM THE CSV
Product.connection.execute <<-SQL
  CREATE TEMP TABLE product_imports
  (
    product_name character varying,
    product_sku character varying,
    advertiser_name character varying,
    advertiser_id integer

  )
SQL

File.open(Rails.root.join('./db/seeds/new_data.csv'), 'r') do |file|
  Product.connection.raw_connection.copy_data %{copy product_imports from stdin with csv header delimiter ',' quote '"'} do
    while line = file.gets do
      Product.connection.raw_connection.put_copy_data line
    end
  end
end

Product.connection.execute <<-SQL
  insert into products(product_name, product_sku, advertiser_name, advertiser_id)
  select product_name, product_sku, advertiser_name, advertiser_id
  from product_imports
  on conflict(id) do
  update set
    product_name = EXCLUDED.product_name,
    product_sku = EXCLUDED.product_sku,
    advertiser_name = EXCLUDED.advertiser_name,
    advertiser_id = EXCLUDED.advertiser_id
  returning id
SQL








# SOME TESTING ON DIFFERENT METHODS


# takes a VERY long time, around 3-4 minutes for ~55k records. no good.
# CSV.foreach("./db/seeds/products.csv") do |row|
#   row[3] = assign_advertiser(row[3])
#   puts row[3]
# end

# ///////
# the standard way of importing csv records, with rails built in CSV.parse
# this also takes too long
# products = File.read("./db/seeds/products.csv")
# products = CSV.parse(products)
#
# products.each do |product|
#   # binding.pry
#   Product.create(product_name: product[0], product_sku: product[1], advertiser_id: assign_advertiser(product[2]), advertiser_name: product[2])
# end

# /////////
# generic copy to the pg database. we need a way to execute assigning the products to the advertisers...
# Product.copy_from "./db/seeds/products.csv"

# so we added an extra column to the database, a duplicate of advertisers names,
# and use our method to translate the id, thereby assuring the relation works

# Product.copy_from "./db/seeds/products.csv" do |row|
#   row[3] = assign_advertiser(row[3])
# end
