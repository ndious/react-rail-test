class ContractsController < ApplicationController
  before_action :user_is_admin, only: [:create, :update, :destroy]
  before_action :set_contract, only: [:show, :update, :destroy]

  def index
    if @current_user.admin?
      @contracts = Contract.not_deleted
    else
      @contracts = @current_user.contracts.not_deleted
    end
  end

  # Current user can only see his own contracts
  def show
    unless @current_user.admin?
      unless @current_user.contracts.include?(@contract)
        render json: { errors: "You don't have access to this contract" }, status: :unauthorized
      end
    end
  end

  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      render json: @contract, status: :create
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    unless @contract.update(create_contract_params)
      render json: { errors: @contract.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @contract.destroy
  end

  private
    def create_contract_params
      params.permit(:start_at, :options, :clients)
    end

    def set_contract
      @contract = Contract.find(params[:id])
    end
end
