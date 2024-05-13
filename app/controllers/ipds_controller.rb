class IpdsController < ApplicationController
  before_action :set_ipd, only: [:show, :update_discharge, :edit_discharge]
  before_action :authenticate_user!
  before_action :authorize_ipd
  #GET /ipds
  def index
    conditions = {}
    conditions[:status] = params[:status] if params[:status].present?
    conditions[:department_id] = params[:department_id] if params[:department_id].present?
    conditions["beds.ward_type"] = params[:ward_type] if params[:ward_type].present?
    @ipds = Ipd.eager_load(:patient, :department, :bed)
               .where(conditions)
               .where("patients.first_name ILIKE ? OR patients.last_name ILIKE ?", "%#{params[:patient_name]}%", "%#{params[:patient_name]}%")
               .order(admission_datetime: :desc)
               .select(:id, :patient_id, "patients.first_name", "patients.last_name", "patients.gender", :department_id, "departments.name", :bed_id, "beds.bed_no", "beds.ward_type", :treatment_description, :admission_datetime, :status)
               .paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.json { render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok }
      format.pdf do
        render pdf: "ipds_report", layout: "pdf"
      end
    end
  end

  def new
    @ipd = Ipd.new
  end

  #PUT /ipds/:id
  def show
    ipd_json = {
      id: @ipd.id,
      patient_id: @ipd.patient.id,
      first_name: @ipd.patient.first_name,
      last_name: @ipd.patient.last_name,
      gender: @ipd.patient.gender,
      department_id: @ipd.department.id,
      department_name: @ipd.department.name,
      bed_id: @ipd.bed.id,
      bed_no: @ipd.bed.bed_no,
      ward_type: @ipd.bed.ward_type,
      treatment_description: @ipd.treatment_description,
      status: @ipd.status,
    }
    respond_to do |format|
      format.html
      format.json { render json: ipd_json, status: :ok }
      format.pdf do
        render pdf: "ipd_report", layout: "pdf"
      end
    end
  end

  #POST /ipds
  #Create new ipd record
  def create
    # Check if the patient is already admitted
    if Ipd.where(patient_id: ipd_params[:patient_id], status: "admitted").exists?
      respond_to do |format|
        format.json { render json: { error: "Patient is already admitted" }, status: :unprocessable_entity }
        format.html { redirect_to root_path, alert: "Patient is already admitted" }
      end
      return
    end

    # Check if the bed is available
    bed = Bed.find_by(id: ipd_params[:bed_id])
    if bed.nil? || bed.status == "acquired"
      respond_to do |format|
        format.json { render json: { error: "Bed is not available" }, status: :unprocessable_entity }
        format.html { redirect_to root_path, alert: "Bed is not available" }
      end
      return
    end

    # Check admission datetime
    admission_datetime = ipd_params[:admission_datetime].presence || DateTime.now
    if admission_datetime > DateTime.now + 2.minutes
      respond_to do |format|
        format.json { render json: { error: "Admission date cannot be in the future" }, status: :unprocessable_entity }
        format.html { redirect_to root_path, alert: "Admission date cannot be in the future" }
      end
      return
    end

    # Create IPD record
    @ipd = Ipd.create!(ipd_params.merge(admission_datetime: admission_datetime, status: "admitted"))
    if @ipd.save
      bed.update(status: "acquired")
      respond_to do |format|
        format.json { render json: { ipd: @ipd.as_json(except: [:created_at, :updated_at]), message: "IPD record created" }, status: :created }
        format.html { redirect_to @ipd, notice: "IPD record created" }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @ipd.errors.full_messages.join(", ") }, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  def edit_discharge
  end

  #PUT /ipds/discharge/:id
  def update_discharge
    if @ipd.status == "discharged"
      respond_to do |format|
        format.html { redirect_to ipds_path, alert: "IPD already discharged" }
        format.json { render json: { error: "IPD already discharged" }, status: :unprocessable_entity }
      end
      return
    end

    @ipd.discharge_datetime = DateTime.now
    @ipd.treatment_description = discharge_ipd_params[:treatment_description]
    @ipd.status = "discharged"

    if @ipd.save
      Bed.find(@ipd.bed_id).update(status: "vacant")
      respond_to do |format|
        format.html { redirect_to ipds_path, notice: "IPD patient discharged!" }
        format.json { render json: { ipd: @ipd.as_json(except: [:created_at, :updated_at]), message: "IPD patient discharged!" }, status: :accepted }
      end
    else
      respond_to do |format|
        format.html { render :discharge }
        format.json { render json: @ipd.errors, status: :unprocessable_entity }
      end
    end
  end

  #GET /ipds/admitted
  #get all ipds (admitted) currently active record
  def get_all_admitted_ipds
    @ipds = Ipd.get_admitted.order(admission_datetime: :desc)
    render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /ipds/ward/admitted
  #all ADMITTED ipds info for specific ward_type like ICU
  def get_all_admitted_ipds_from_ward
    @ipds = Ipd.joins(:bed).where('bed.ward_type': ward_type_params[:ward_type]).get_admitted.order(admission_datetime: :desc)
    render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /ipds/ward
  #all ipds info for specific ward_type like ICU
  def get_all_ipds_from_ward
    @ipds = Ipd.joins(:bed).where('bed.ward_type': ward_type_params[:ward_type]).order(admission_datetime: :desc)
    render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #PUT /ipds/:id
  #for change or shifting patient

  private

  def set_ipd
    @ipd = Ipd.eager_load(:patient, :department, :bed).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "IPD Record not found" }, status: :not_found
  end

  def ipd_params
    params.require(:ipd).permit(:patient_id, :bed_id, :department_id, :admission_datetime)
  end

  def ward_type_params
    params.permit(:ward_type)
  end

  def discharge_ipd_params
    params.permit(:treatment_description)
  end

  def authorize_ipd
    authorize Ipd
  end
end
