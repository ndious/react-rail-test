class ApplicationController < ActionController::API
  def index
    render plain: "hello"
  end

  def show
    render json: {
      hello: "world"
    }.to_json
  end
end
