class BedsController < ApplicationController
  before_action :set_bed, only: [:show, :update]

  # GET /beds
  def index
    conditions = {}
    conditions[:status] = params[:status] if params[:status].present?
    conditions[:ward_type] = params[:ward_type] if params[:ward_type].present?
    @beds = Bed.where(conditions)
    render json: @beds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  # GET /beds/1
  def show
    ipd_id = nil
    if (@bed.status == "acquired")
      ipd_id = @bed.ipds.find_by(status: "admitted").id
    end

    render json: @bed.as_json(except: [:created_at, :updated_at]).merge(ipd_id: ipd_id), status: :ok
  end

  # POST /beds
  def create
    @bed = Bed.new(bed_params)
    if @bed.save
      render json: { bed: @bed.as_json(except: [:created_at, :updated_at]), message: "Bed successfully added" }, status: :created
    else
      render json: @bed.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beds/1
  def update
    if @bed.status == "acquired"
      render json: { error: "Currently Bed status is acquired..Discharge patient first" }, status: :unprocessable_entity
      return
    end

    if bed_update_params[:status] == "vaccant" || bed_update_params[:status] == "unavailable"
      if @bed.update(bed_update_params)
        render json: { bed: @bed.as_json(except: [:created_at, :updated_at]), message: "Bed status successfully updated" }, status: :accepted
      else
        render json: @bed.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Status Not Acceptable" }, status: :unprocessable_entity
    end
  end

  #GET /beds/all
  def get_all_beds_and_ipds
    render json: Bed.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no, :status, :patient_id).as_json
  end

  #GET /beds/all/vaccant
  def get_vaccant_beds
    @beds_ipd = if ward_param[:ward_type].present?
        Bed.get_vaccant.where(ward_type: ward_param[:ward_type]).left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).as_json
      else
        Bed.get_vaccant.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).uniq.as_json
      end
    render json: @beds_ipd, status: :ok
  end

  #GET /beds/all/acquired
  def get_acquired_beds_and_ipds
    if ward_param[:ward_type].present?
      @beds_ipd = Bed.get_acquired.where(ward_type: ward_param[:ward_type]).left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).as_json
    else
      @beds_ipd = Bed.get_acquired.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no, :patient_id).as_json
    end
    render json: @beds_ipd, status: :ok
  end

  #GET /beds/ward_types
  #all ward types

  def get_ward_types
    render json: Bed::WARD_TYPES.as_json, status: :ok
  end

  private

  def set_bed
    @bed = Bed.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Bed Details not found" }, status: :not_found
  end

  def bed_params
    params.require(:bed).permit(:ward_type, :bed_no, :status)
  end

  def bed_update_params
    params.require(:bed).permit(:status)
  end

  def ward_param
    params.permit(:ward_type)
  end
end
