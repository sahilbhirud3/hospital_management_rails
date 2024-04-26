class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :change_password]

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
  # Update user's first name and last name
  def update
    if @user.update!(user_params_update)
      render json: { message: "User updated successfully" }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /users/:id/change_password
  # change user password
  def change_password
    @user = User.find(params[:id])

    if @user.authenticate(params[:old_password])
      if @user.update(password: params[:new_password])
        render json: { message: "Password changed successfully" }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Old password is incorrect" }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def user_params_update
    params.permit(:first_name, :last_name)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact, :password)
  end
end
