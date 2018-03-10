class ApplicationController < ActionController::API

  def index_to_show
    index = request.headers['HTTP_CURRENT_INDEX']
  end

end
