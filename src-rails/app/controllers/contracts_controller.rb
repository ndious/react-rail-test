class ContractsController < ApplicationController
  before_action :user_is_admin, only: [:create, :update, :destroy]
  before_action :set_contract, only: [:show, :update, :cancel, :destroy]
  before_action :user_can_access_contract, only: [:show, :cancel]

  def index
    if @current_user.admin?
      @contracts = Contract.not_deleted
    else
      @contracts = @current_user.contracts.not_deleted
    end
  end

  # Current user can only see his own contracts
  def show
  end

  def cancel
    begin
      validate_cancel_date
    rescue Exception => e
      return render json: { error: e.message }, status: :unprocessable_entity
    end

    unless @contract.update(cancel_contract_params)
      render json: { errors: @contract.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Actions only for admins
  def create
    @contract = Contract.new(create_contract_params)

    begin
      load_users
      load_options
    rescue Exception => e
      return render json: { errors: e.message }, status: :unprocessable_entity
    end

    @contract.users = @users
    @contract.options = @options

    if @contract.save
      render json: @contract, status: :created
    else
      render json: { errors: @contract.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    unless @contract.update(update_contract_params)
      render json: { errors: @contract.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    # Is not possible to delete a contract if it is active
    unless @contract.finished?
      render json: { errors: ['Contract can not be deleted'] }, status: :unprocessable_entity
    end

    @contract.deleted_at = Time.now
    @contract.save

    render json: { id: @contract.id }, status: :ok
  end

  private
    def create_contract_params
      params.permit(:start_at, :end_at)
    end

    def update_contract_params
      params.permit(:start_at, :end_at)
    end

    def load_options
      @options = Option.where id: params[:options_id]

      unless @options.length == params[:options_id].length 
        missing_options = params[:options_id] - @options.map(&:id)
        raise Exception.new "Missing options: #{missing_options.join(' ')}"
      end
    end

    def load_users
      @users = User.where id: params[:clients_id]

      unless @users.length == params[:clients_id].length
        missing_users = params[:clients_id] - @users.map(&:id)
        raise Exception.new "Missing users: #{missing_users.join(' ')}"
      end
    end

    def validate_cancel_date
      if cancel_contract_params[:end_at].nil?
        throw :halt, render(json: { errors: ['End date is required'] }, status: :unprocessable_entity)
      end

      end_at = Date.parse(cancel_contract_params[:end_at])

      if end_at < @contract.start_at
        raise Exception.new "End date can't be before start date"
      end

      if end_at < Time.now
        raise Exception.new "End date must be in the future"
      end

      if @contract.finished?
        raise Exception.new "Contract is already finished"
      end
    end

    def cancel_contract_params
      params.permit(:end_at)
    end

    def set_contract
      @contract = Contract.find(params[:id])
    end

    def user_can_access_contract
      unless @current_user.admin? || @contract.users.include?(@current_user)
        render json: { errors: "You don't have access to this contract" }, status: :unauthorized
      end
    end
end
