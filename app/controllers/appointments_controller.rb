class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :cancel_appointment]
  # GET /appointments
  # all appointments
  def index
    @appointments = Appointment.all.order(slot_start_datetime: :desc).as_json(except: [:created_at, :updated_at])
    render json: @appointments, status: :ok
  end

  # GET /appointments/:id
  # get appointments
  def show
    render json: @appointment.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  # POST /appointments
  # to create appointment
  def create
    # Check if patient_id is provided
    if appointment_params[:patient_id].present?
      patient_id = appointment_params[:patient_id]
    else
      # If patient_id is not provided, create a new patient
      @patient = Patient.new(patient_params.merge(user_id: appointment_params[:user_id]))
      unless @patient.save
        return render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
      end
      patient_id = @patient.id
    end

    # Check if patient already has a scheduled appointment for the given doctor today
    if Appointment.where(patient_id: patient_id, doctor_id: appointment_params[:doctor_id], status: "scheduled", slot_start_datetime: Date.today.all_day).exists?
      return render json: { error: "Patient already has a scheduled appointment for the given doctor" }, status: :unprocessable_entity
    end

    # Check if patient is already admitted
    if Ipd.find_by(patient_id: patient_id, status: "admitted").present?
      return render json: { error: "Patient is already admitted" }, status: :unprocessable_entity
    end

    # Check if appointment slot is available for the given doctor
    if Appointment.where(slot_start_datetime: DateTime.parse("#{appointment_params[:slot_start_datetime]} IST"), doctor_id: appointment_params[:doctor_id]).exists?
      return render json: { error: "Appointment not available for the given doctor" }, status: :unprocessable_entity
    end

    # Create new appointment
    @appointment = Appointment.new(appointment_params.merge(patient_id: patient_id))

    if @appointment.save
      render json: @appointment.as_json(except: [:created_at, :updated_at]), status: :created
    else
      render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #GET /appointments/doctor/:doctor_id/all
  #get all doctor's(doctor_id) appointments
  def get_all_appointments_for_doctor
    @appointments = Appointment.where(doctor_id: params[:doctor_id])
    render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /appointments/user/:user_id
  #get all appointments booked by user
  def get_all_appointments_for_user
    @appointments = Appointment.where(user_id: params[:user_id]).order(slot_start_datetime: :desc)
    render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /appointments/doctor/:doctor_id/today
  #get today's doctor's(doctor_id) appointments
  def get_todays_appointment_for_doctor
    @appointments = Appointment.where(doctor_id: params[:doctor_id]).where("DATE(slot_start_datetime) = ?", DateTime.now)
    render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #PUT /appointments/:id/cancel
  #cancel the appointment
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
    params.permit(:user_id, :doctor_id, :patient_id, :slot_start_datetime, :slot_end_datetime, :appointment_type)
  end

  def patient_params
    params.permit(:first_name, :last_name, :birthdate, :gender, :contact)
  end
end
