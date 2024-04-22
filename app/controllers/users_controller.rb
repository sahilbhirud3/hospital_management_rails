class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  # GET /users
  # get all users
  def index
    conditions = {}
    conditions[:role] = params[:role] if params[:role].present?
    @users = User.all.where(conditions)
    render json: @users.as_json({ only: [:id, :first_name, :last_name, :email, :contact, :role] }), status: :ok
  end

  # GET /users/:id
  # get user
  def show
    render json: @user.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role]), status: :ok
  end

  # POST /users
  # create user
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role]), message: "User registered successfully" }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  # get all users
  def update
    if @user.update(user_params)
      render json: { message: "User updated successfully" }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact, :password)
  end
end
