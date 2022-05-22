class OptionsController < ApplicationController
  before_action :user_is_admin

  def index
    @options = Option.all
  end

  def show
    @option = Option.find(params[:id])
    render json: @option, status: :ok
  end
end
