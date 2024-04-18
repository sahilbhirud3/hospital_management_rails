class BedsController < ApplicationController
  before_action :set_bed, only: [:show, :update]

  # GET /beds
  def index
    @beds = Bed.all
    render json: @beds.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  # GET /beds/1
  def show
    render json: @bed.as_json(except: [:created_at, :updated_at]), status: :ok
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
    if @bed.update(bed_params)
      render json: { bed: @bed.as_json(except: [:created_at, :updated_at]), message: "Bed successfully updated" }, status: :accepted
    else
      render json: @bed.errors, status: :unprocessable_entity
    end
  end

  #GET /beds/all
  def get_all_beds_and_ipds
    render json: Bed.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no, :status, :patient_id).as_json
  end

  #GET /beds/all/vaccant
  def get_vaccant_beds
    if ward_param[:ward_type].present?
      @beds_ipd = Bed.get_vaccant.where(ward_type: ward_param[:ward_type]).left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).as_json
    else
      @beds_ipd = Bed.get_vaccant.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).as_json
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

  private

  def set_bed
    @bed = Bed.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Bed Details not found" }, status: :not_found
  end

  def bed_params
    params.require(:bed).permit(:ward_type, :bed_no, :status)
  end

  def ward_param
    params.permit(:ward_type)
  end
end
