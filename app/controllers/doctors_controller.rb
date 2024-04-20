# app/controllers/doctors_controller.rb
class DoctorsController < ApplicationController
  #GET /doctors
  #all doctors
  def index
    @doctors = User.get_doctors.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role])
    render json: @doctors, status: :ok
  end

  #GET /doctors/department/:deptid
  #all doctors from particular(deptid) department
  def get_all_doctors_from_department
    @doctor_names = DoctorDetail.joins(:user, :department).where(department_id: params[:deptid]).pluck(:user_id, :first_name, :last_name)
    result = @doctor_names.map do |user_id, first_name, last_name|
      { id: user_id, first_name: first_name, last_name: last_name }
    end
    render json: result, status: :ok
  end

  #POST /doctors
  #insert doctor and doctors_details
  def create
    @user = User.new(doctor_params)
    if @user.save
      @doctor_detail = @user.build_doctor_detail(doctor_params[:doctor_detail_attributes])

      if @doctor_detail.save
        render json: { user: @user.as_json(only: [:id, :first_name, :last_name, :email, :contact, :role]), doctor_detail: @doctor_detail, message: "Doctor registered successfully" }, status: :created
      else
        render json: @doctor_detail.errors, status: :unprocessable_entity
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #GET /doctors/:id/availableslots
  #today's available appointment for doctor
  def todays_available_appointment_slot_for_doctor
    @available_slots = AppointmentsHelper.available_slots(params[:id])
    if @available_slots.empty?
      render json: { error: "No Appointments" }, status: :not_found
      return
    end
    render json: @available_slots, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Doctor not found" }, status: :not_found
  end

  #GET /doctors/:id
  def show
    doctors_with_users = DoctorDetail.joins(:user).joins(:department).find_by(user_id: params[:id])
    raise ActiveRecord::RecordNotFound if doctors_with_users.nil?

    doctors_with_users_json = doctors_with_users.as_json(
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
    render json: doctors_with_users_json, status: :ok
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
end
