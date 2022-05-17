class OptionsController < ApplicationController
  before_action :user_is_admin

  def index
    @options = ContractOption.all
  end

  def show
    @option = ContractOption.find(params[:id])
    render json: @option, status: :ok
  end
end
