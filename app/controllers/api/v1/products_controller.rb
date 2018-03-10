class Api::V1::ProductsController < ApplicationController

  @@Start = 1

  def index
    @products = Product.all
    render json: {current_index: @@Start + 1000, products: [@products[0...1000]]}
  end

  def more
    index = index_to_show.to_i
    new_index = index.to_i + 1000
    show_until = index.to_i + 999
    @products = Product.all
    # binding.pry
    render json: {current_index: new_index, products: [@products[index - 1...show_until]]}
  end

end
