class UsersController < ApplicationController
  before_action :user_is_admin , only: [:index, :create, :destroy]
  before_action :set_user, only: [:show]
  before_action :user_can_access_contract, only: [:show]

  def index
    @users = User.all
  end

  def show
  end

  def create
    @user = User.new(create_user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.deleted_at = Time.now
    @user.email = "#{@user.id}@delet.ed"
    @user.password_digest = "deleted"
    @user.save

    render json: { message: "User deleted", id: @user.id }, status: :ok
  end

  private
    def create_user_params
      params.permit(:email, :password, :password_confirmation, :role)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_can_access_contract
      unless @current_user.admin? || @user == @current_user
        render json: { error: 'You are not authorized to access this resource' }, status: :unauthorized
      end
    end
end
