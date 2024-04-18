class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show]
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
    if appointment_params[:patient_id].present?
      if Appointment.where(patient_id: appointment_params[:patient_id], doctor_id: appointment_params[:doctor_id], status: "scheduled").exists?
        render json: { error: "Patient Already have scheduled Appointment for given Doctor" }, status: :unprocessable_entity
        return
      end
      if Appointment.where(slot_start_datetime: appointment_params[:slot_start_datetime], doctor_id: appointment_params[:doctor_id]).exists?
        render json: { error: "Appointment not available for given Doctor" }, status: :unprocessable_entity
        return
      end
      @appointment = Appointment.new(appointment_params)
    else
      @patient = Patient.new(patient_params.merge(user_id: appointment_params[:user_id]))
      if @patient.save
        if Appointment.where(slot_start_datetime: appointment_params[:slot_start_datetime], doctor_id: appointment_params[:doctor_id]).exists?
          render json: { error: "Appointment not available for given Doctor" }, status: :unprocessable_entity
          return
        end
        @appointment = Appointment.new(appointment_params.merge(patient_id: @patient.id))
      else
        render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
        return
      end
    end

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

  #GET /appointments/doctor/:doctor_id/today
  #get today's doctor's(doctor_id) appointments
  def get_todays_appointment_for_doctor
    @appointments = Appointment.where(doctor_id: params[:doctor_id]).where("DATE(slot_start_datetime) = ?", DateTime.now)
    render json: @appointments.as_json(except: [:created_at, :updated_at]), status: :ok
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
