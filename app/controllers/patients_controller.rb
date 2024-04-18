class PatientsController < ApplicationController
  before_action :set_patient, only: [:show]
  #GET /patients
  def index
    @patients = Patient.all
    render json: @patients.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #POST /patients
  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      render json: { patient: @patient.as_json(except: [:created_at, :updated_at]), message: "Patient Data Registerd Sccessfully." }, status: :created
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  #PUT /patients/:id
  def show
    render json: @patient.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /patients/user/:user_id
  def get_all_patients_for_user
    patients = Patient.where(user_id: params[:user_id])
    render json: [] if patients.empty?
    render json: patients.as_json(only: [:id, :first_name, :last_name, :gender, :contact])
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Patient Record not found" }, status: :not_found
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :birthdate, :gender, :contact, :user_id)
  end
end
