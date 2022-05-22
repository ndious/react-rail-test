class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :default_format_json

  before_action :authenticate_request

  protected
    def user_is_admin
      if @current_user.client?
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end

    def authenticate_request
      header = request.headers["Authorization"]
      header = header.split(" ").last if header

      if header.nil? 
        render json: { error: "unauthorized" }, status: :unauthorized 
      else
        decoded = jwt_decode(header)
        @current_user = User.find(decoded[:user_id])
      end
    end

    def default_format_json
      request.format = "json"
    end
end
