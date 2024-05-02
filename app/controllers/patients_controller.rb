class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update]
  before_action :authenticate_user!
  before_action :authorize_patient
  # GET /patients
  def index
    @patients = Patient.all.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.json { render json: @patients.as_json(except: [:created_at, :updated_at]), status: :ok }
    end
  end

  def edit
  end

  def new
    @patient = Patient.new
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)
    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: "Patient data registered successfully." }
        format.json { render json: { patient: @patient.as_json(except: [:created_at, :updated_at]), message: "Patient data registered successfully." }, status: :created }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /patients/:id
  def show
    respond_to do |format|
      format.html
      format.json { render json: @patient.as_json(except: [:created_at, :updated_at]), status: :ok }
    end
  end

  # GET /patients/user/:user_id
  def get_all_patients_for_user
    patients = Patient.where(user_id: params[:user_id])
    respond_to do |format|
      format.json { render json: patients.as_json(only: [:id, :first_name, :last_name, :gender, :contact]) }
    end
  end

  # PATCH/PUT /patients/1
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: "Patient was successfully updated." }
        format.json { render json: { patient: @patient.as_json(only: [:id, :name, :address]), message: "Patient successfully updated." }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to patients_path, alert: "Patient record not found." }
      format.json { render json: { error: "Patient record not found" }, status: :not_found }
    end
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :birthdate, :gender, :contact, :user_id)
  end

  def authorize_patient
    authorize Patient
  end
end
