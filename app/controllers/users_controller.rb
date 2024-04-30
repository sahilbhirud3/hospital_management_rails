  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :change_password]
    before_action :require_admin, only: [:new_user]


    def new_user
      @user = User.new
      @user.build_doctor_detail
    end

    def create_user
      @user = User.new(user_params1)
      @user.role = "doctor"
      @user.password = "123456" # Set default password

      if @user.save
        redirect_to root_path, notice: "User created successfully"
      else
        render :new_user
      end
    end




    # GET /users
    # get all users
    def index
      conditions = {}
      conditions[:role] = params[:role] if params[:role].present?
      @users = User.all.where(conditions)

      respond_to do |format|
        format.json { render json: @users.as_json({ only: [:id, :first_name, :last_name, :email, :contact, :role] }), status: :ok }
        format.html { @users }
      end
    end

    # GET /users/:id
    # get user
    def show
      respond_to do |format|
        format.json { render json: @user.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role]), status: :ok }
        format.html { @user }
      end
    end

    # POST /users
    # create user
    def create

      @user = User.new(user_params)
      if @user.save
        render json: { user: @user.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role]), message: "User registered successfully" }, status: :created
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
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
# dashboard
    def dashboard
      # User dashboard logic
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

  def require_admin
    redirect_to root_path unless current_user.role=="admin"
  end

  def user_params1
    params.require(:user).permit(:first_name, :last_name, :email, :contact, :password, :password_confirmation,
                                 doctor_detail_attributes: [:regno, :department_id, :start_time, :end_time, :required_time_slot, :qualification])
  end
  end
