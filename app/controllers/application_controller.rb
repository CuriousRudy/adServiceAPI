class ApplicationController < ActionController::API

  # read the header with the current index
  def index_to_show
    index = request.headers['HTTP_CURRENT_INDEX']
  end

end
