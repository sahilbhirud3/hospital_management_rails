class IpdsController < ApplicationController
  before_action :set_ipd, only: [:show]

  #GET /ipds
  #get all ipds
  def index
    @ipds = Ipd.all
    render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #PUT /ipds/:id
  def show
    render json: @ipd.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #POST /ipds
  #Create new ipd record
  def create
    @ipd = Ipd.new(ipd_params)
    if @ipd.save
      render json: { ipd: @ipd.as_json(except: [:created_at, :updated_at]), message: "IPD record Created" }, status: :created
    else
      render json: @ipd.errors, status: :unprocessable_entity
    end
  end

  #GET /ipds/admitted
  #get all ipds (admitted) currently active record
  def get_all_admitted_ipds
    @ipds = Ipd.admitted
    render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /ipds/ward/admitted
  #all ADMITTED ipds info for specific ward_type like ICU
  def get_all_admitted_ipds_from_ward
    @ipds = Ipd.joins(:bed).where('bed.ward_type': ward_type_params[:ward_type]).admitted
    render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /ipds/ward
  #all ipds info for specific ward_type like ICU
  def get_all_ipds_from_ward
    @ipds = Ipd.joins(:bed).where('bed.ward_type': ward_type_params[:ward_type])
    render json: @ipds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  private

  def set_ipd
    @ipd = Ipd.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "IPD Record not found" }, status: :not_found
  end

  def ipd_params
    params.require(:ipd).permit(:patient_id, :bed_id, :department_id, :treatment_description, :admission_datetime, :discharge_datetime, :status)
  end

  def ward_type_params
    params.permit(:ward_type)
  end
end
