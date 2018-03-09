class Api::V1::ProductsController < ApplicationController

  def index
    expires_in 6.hours, public: false
    @products = Product.all
    render json: ProductSerializer.new(@products)
  end

end
