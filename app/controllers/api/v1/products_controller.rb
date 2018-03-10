class Api::V1::ProductsController < ApplicationController

  @@Start = 1
  @@Product_count = Product.count

  # sends a header to keep count for each 1000 records
  def index
    @products = Product.all
    render json: {current_index: @@Start + 1000, products: [@products[0...1000]]}
  end

  # includes the logic to go through each index
  def more
    if @@Product_count - index_to_show.to_i <= 1000
      index = index_to_show.to_i
      new_index = @@Product_count
      show_until = index_to_show.to_i + (@@Product_count - index_to_show.to_i).abs
    else
      index = index_to_show.to_i
      new_index = index + 1000
      show_until = index + 999
    end
    @products = Product.all
    # binding.pry
    render json: {current_index: new_index, products: [@products[index - 1...show_until]]}
  end

end
