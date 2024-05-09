class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :cancel_appointment]
  before_action :authenticate_user!
  before_action :authorize_appointment

  # GET /appointments
  # all appointments
  def index
    @doctor_names = DoctorDetail.joins(:user, :department).pluck(:user_id, :first_name, :last_name)
    @doctors = @doctor_names.map do |user_id, first_name, last_name|
      { id: user_id, first_name: first_name, last_name: last_name }
    end
    conditions = {}

    if current_user.role == "user"
      conditions = { user_id: current_user.id }
    elsif current_user.role == "doctor"
      conditions = { doctor_id: current_user.id }
    end

    conditions[:status] = params[:status] if params[:status].present?
    if current_user.role == "user" || current_user.role == "admin"
      conditions[:doctor_id] = params[:doctor_id] if params[:doctor_id].present?
    end
    @search_date = params[:date]
    conditions[:slot_start_datetime] = Date.parse(params[:date].to_s).beginning_of_day..Date.parse(params[:date].to_s).end_of_day if params[:date].present?
    @appointments = Appointment.includes(:patient, :doctor, :user).order(slot_start_datetime: :desc).where(conditions)
    @appointments = @appointments.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.json { render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok }
    end
  end

  def update_status
    @appointment = Appointment.find(params[:id])
    if @appointment.update(status: params[:status])
      respond_to do |format|
        format.js
        format.html do
          flash[:notice] = "Appointment status updated"
          redirect_back_or_to appointments_path
        end

      end
    else
      flash[:alert] = "Something went wrong!"
      redirect_to appointments_path
    end
  end

  def new
    @departments = Department.all
    @appointment = Appointment.new
    @patients = Patient.all.where(user_id: current_user.id)
  end

  # GET /appointments/:id
  # get appointments
  def show
    render json: @appointment.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  # POST /appointments
  # to create appointment
  def create
    patient_id = appointment_params[:patient_id].presence || create_new_patient&.id

    if patient_already_has_scheduled_appointment?(patient_id)
      return render_error("Patient already has a scheduled appointment for the given doctor")
    end

    if patient_already_admitted?(patient_id)
      return render_error("Patient is already admitted")
    end

    if appointment_not_available_for_doctor?
      return render_error("Appointment not available for the given doctor")
    end

    # "2024-05-04 15:00"
    @doctor = DoctorDetail.find_by(user_id: appointment_params[:doctor_id])
    start_datetime = DateTime.parse(appointment_params[:slot_start_datetime])
    slot_end_datetime = start_datetime + @doctor.required_time_slot.minutes
    formatted_end_datetime = slot_end_datetime.strftime("%Y-%m-%d %H:%M")
    # Merge the adjusted slot_end_datetime into the appointment_params
    adjusted_appointment_params = appointment_params.merge(slot_end_datetime: formatted_end_datetime)
    @appointment = Appointment.new(adjusted_appointment_params)

    if @appointment.save
      respond_to do |format|
        format.html { redirect_to user_appointments_path(current_user), notice: "Appointment was successfully created." }
        format.json { render json: @appointment.as_json(except: [:created_at, :updated_at]), status: :created }
      end
    else
      render_error(@appointment.errors.full_messages)
    end
  end

  # GET /appointments/doctor/:doctor_id/all
  # get all doctor's(doctor_id) appointments
  def get_all_appointments_for_doctor
    @appointments = Appointment.where(doctor_id: params[:doctor_id])
    render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  # GET /appointments/user/:user_id
  # get all appointments booked by user
  def get_all_appointments_for_user
    @appointments = Appointment.where(user_id: params[:user_id]).order(slot_start_datetime: :desc)
    render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  # GET /appointments/doctor/:doctor_id/today
  # get today's doctor's(doctor_id) appointments
  def get_todays_appointment_for_doctor
    @appointments = Appointment.where(doctor_id: params[:doctor_id]).where("DATE(slot_start_datetime) = ?", DateTime.now)
    render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  # PUT /appointments/:id/cancel
  # cancel the appointment
  def cancel_appointment
    if @appointment.status == "cancelled"
      render json: { error: "Appointment already Cancelled" }, status: :unprocessable_entity
      return
    end
    @appointment.update(status: "cancelled")
    render json: {
             message: "Appointment Cancelled",
             appointment: @appointment.as_json(except: [:created_at, :updated_at]),
           }, status: :ok
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Appointment not found" }, status: :not_found
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :doctor_id, :patient_id, :slot_start_datetime, :appointment_type)
  end

  def appointment_params1
    params.require(:appointment).permit(:status)
  end

  def patient_params
    params.permit(:first_name, :last_name, :birthdate, :gender, :contact)
  end

  def create_new_patient
    @patient = Patient.new(patient_params.merge(user_id: appointment_params[:user_id]))
    @patient.save ? @patient : nil
  end

  def patient_already_has_scheduled_appointment?(patient_id)
    Appointment.where(patient_id: patient_id, doctor_id: appointment_params[:doctor_id], status: "scheduled", slot_start_datetime: Date.today.all_day).exists?
  end

  def patient_already_admitted?(patient_id)
    Ipd.find_by(patient_id: patient_id, status: "admitted").present?
  end

  def appointment_not_available_for_doctor?
    Appointment.where(slot_start_datetime: appointment_params[:slot_start_datetime], doctor_id: appointment_params[:doctor_id]).exists?
  end

  def authorize_appointment
    authorize Appointment
  end

  def render_error(message)
    respond_to do |format|
      format.html { redirect_to user_appointments_path(current_user), alert: message }
      format.json { render json: { errors: message }, status: :unprocessable_entity }
    end
  end
end
