# app/controllers/doctors_controller.rb
class DoctorsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_doctor_details, only: [:index, :show, :edit, :update]
  #GET /doctors
  #all doctors
  def index
    @doctors = User.includes(doctor_detail: :department)
      .select(:id, :first_name, :last_name, :email, :contact, :role, "departments.name as department_name")
      .joins(doctor_detail: :department)
      .paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.json { render json: @doctors.as_json(except: [:department_id], methods: [:department_name]), status: :ok }
      format.html
    end
  end

  #POST /doctors
  #insert doctor and doctors_details
  def create
    ActiveRecord::Base.transaction do
      @user = User.new(doctor_params)
      if @user.save
        @doctor_detail = @user.build_doctor_detail(doctor_params[:doctor_detail_attributes])
        if @doctor_detail.save
          render json: { user: @user.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role]), doctor_detail: @doctor_detail, message: "Doctor registered successfully" }, status: :created
        else
          render json: @doctor_detail.errors, status: :unprocessable_entity
          raise ActiveRecord::Rollback # Rollback the transaction if doctor details saving fails
        end
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  #GET /doctors/:id/availableslots
  #today's available appointment for doctor
  def todays_available_appointment_slot_for_doctor
    @available_slots = AppointmentsHelper.available_slots(params[:id])
    if @available_slots.empty?
      render json: { message: "No Appointments" }, status: :ok
      return
    end
    render json: @available_slots, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Doctor not found" }, status: :not_found
  end

  def dashboard
    @appointment_count = Appointment.where(doctor_id: current_user.id).count
    @todays_appointment_count = Appointment.where(doctor_id: current_user.id).where(slot_start_datetime: (Date.today.beginning_of_day..Date.today.end_of_day)).count
    @todays_checked_appointment_count = Appointment.where(doctor_id: current_user.id).where(slot_start_datetime: (Date.today.beginning_of_day..Date.today.end_of_day)).where(status: "checked").count
  end

  def edit
    @doctor = DoctorDetail.joins(:user).joins(:department).find_by(user_id: params[:id])
    @user = User.find(params[:id])
  end

  def update
    @doctor = DoctorDetail.joins(:user).joins(:department).find_by(user_id: params[:id])
    if @doctor.update(doctor_edit_params)
      redirect_to doctor_path(@doctor.user_id), notice: "Doctor was successfully updated."
    else
      flash[:alert] = @doctor.errors.full_message(:required_time_slot, " is not acceptable")
      render :edit
    end
  end

  #GET /doctors/:id
  def show
    @doctor = DoctorDetail.joins(:user).joins(:department).find_by(user_id: params[:id])
    @user = User.find(params[:id])
    raise ActiveRecord::RecordNotFound if @doctor.nil?

    doctor_json = @doctor.as_json(
      include: {
        user: {
          only: [:id, :first_name, :last_name, :email, :contact],
        },
        department: {
          only: [:id, :name],
        },
      },
      only: [:regno, :start_time, :end_time, :required_time_slot, :qualification],
    )
    respond_to do |format|
      format.json { render json: doctor_json, status: :ok }
      format.html { @doctor }
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Doctor not found" }, status: :not_found
  end

  private

  def doctor_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :contact, :password, :role,
      doctor_detail_attributes: [:regno, :department_id, :start_time, :end_time, :required_time_slot, :qualification],
    )
  end

  def doctor_edit_params
    params.require(:doctor_detail).permit(:start_time, :end_time, :required_time_slot)
  end

  def authorize_doctor_details
    authorize DoctorDetail
  end
end
