class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :change_password]
  before_action :authenticate_user!
  before_action :authorize_user

  def new_doctor_user
    @user = User.new
    @user.build_doctor_detail
  end

  def create_doctor_user
    @user = User.new(user_params1)
    @user.role = "doctor"
    @user.password = "123456" # Set default password

    if @user.save
      redirect_to root_path, notice: "User created successfully"
    else
      flash.now[:alert] = "Error: User could not be created."
      render :new_user
    end
  end

  # GET /users
  def index
    conditions = {}
    conditions[:role] = params[:role] if params[:role].present?
    @users = User.all.where(conditions).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.json { render json: @users.as_json({ only: [:id, :first_name, :last_name, :email, :contact, :role] }), status: :ok }
      format.html { @users }
    end
  end

  # GET /users/:id
  def show
    respond_to do |format|
      format.json { render json: @user.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role]), status: :ok }
      format.html { @user }
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User registered successfully"
    else
      flash[:alert] = "Error: User could not be registered."
      render :new
    end
  end

  # PUT /users/:id
  def update
    if @user.update(user_params_update)
      redirect_to @user, notice: "User updated successfully"
    else
      flash[:alert] = "Error: User could not be updated."
      render :edit
    end
  end

  # PUT /users/:id/change_password
  def change_password
    if @user.authenticate(params[:old_password])
      if @user.update(password: params[:new_password])
        redirect_to @user, notice: "Password changed successfully"
      else
        flash[:alert] = "Error: Password could not be changed."
        render :change_password
      end
    else
      flash[:alert] = "Old password is incorrect."
      render :change_password
    end
  end

  # Dashboard
  def dashboard
    @patient_count = Patient.where(user_id: current_user.id).count
    @appointment_count = Appointment.where(user_id: current_user.id).count
    @todays_appointment_count = Appointment.where(slot_start_datetime: (Date.today.beginning_of_day..Date.today.end_of_day)).count
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Error: User not found."
    redirect_to root_path
  end

  def user_params_update
    params.permit(:first_name, :last_name)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact, :password)
  end

  def user_params1
    params.require(:user).permit(:first_name, :last_name, :email, :contact, :password, :password_confirmation,
                                 doctor_detail_attributes: [:regno, :department_id, :start_time, :end_time, :required_time_slot, :qualification])
  end

  def authorize_user
    authorize User
  end
end
