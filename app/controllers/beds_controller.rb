class BedsController < ApplicationController
  before_action :set_bed, only: [:show, :edit, :update, :toggle_status]
  before_action :authenticate_user!
  before_action :authorize_bed

  # GET /beds
  def index
    conditions = {}
    conditions[:status] = params[:status] if params[:status].present?
    conditions[:ward_type] = params[:ward_type] if params[:ward_type].present?
    @beds = Bed.where(conditions).order(ward_type: :asc).order(Arel.sql("CAST(bed_no AS INTEGER) ASC")).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.json { render json: @beds.as_json(except: [:created_at, :updated_at]), status: :ok }
    end
  end

  # GET /beds/new
  def new
    @bed = Bed.new
  end

  def toggle_status
    # Rails.logger.info("Received params: #{params.inspect}")
    @bed.status = @bed.status == "vaccant" ? "unavailable" : "vaccant"

    if @bed.save
      flash[:success] = "Status updated successfully."
    else
      flash[:alert] = "Failed to update status."
    end
    respond_to do |format|
      format.html { redirect_to beds_path }
      format.js
    end
  end

  # GET /beds/1/edit
  def edit
  end

  # GET /beds/1
  def show
    ipd_id = nil
    if @bed.status == "acquired"
      ipd_id = @bed.ipds.find_by(status: "admitted").id
    end
    respond_to do |format|
      format.html
      format.json { render json: @bed.as_json(except: [:created_at, :updated_at]).merge(ipd_id: ipd_id), status: :ok }
    end
  end

  # POST /beds
  def create
    if Bed.where(bed_no: bed_params[:bed_no], ward_type: bed_params[:ward_type]).exists?
      respond_to do |format|
        format.html {
          redirect_to new_bed_path, alert: "Bed with given number and ward_type is Already Present"
        }
        format.json { render json: { error: "Bed with given number and ward_type is Already Present" }, status: :unprocessable_entity }
      end
    else
      @bed = Bed.new(bed_params)
      respond_to do |format|
        if @bed.save
          format.html { redirect_to @bed, notice: "Bed successfully added" }
          format.json { render json: { bed: @bed.as_json(except: [:created_at, :updated_at]), message: "Bed successfully added" }, status: :created }
        else
          format.html { render :new }
          format.json { render json: @bed.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /beds/1
  def update
    if @bed.status == "acquired"
      render json: { error: "Currently Bed status is acquired..Discharge patient first" }, status: :unprocessable_entity
      return
    end

    if bed_update_params[:status] == "vacant" || bed_update_params[:status] == "unavailable"
      if @bed.update(bed_update_params)
        render json: { bed: @bed.as_json(except: [:created_at, :updated_at]), message: "Bed status successfully updated" }, status: :accepted
      else
        render json: @bed.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Status Not Acceptable" }, status: :unprocessable_entity
    end
  end

  # GET /beds/all
  def get_all_beds_and_ipds
    @beds = Bed.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no, :status, :patient_id)
    respond_to do |format|
      format.html { render :get_all_beds_and_ipds } # Assuming you have a get_all_beds_and_ipds.html.erb view template
      format.json { render json: @beds.as_json }
    end
  end

  # GET /beds/all/vacant
  def get_vacant_beds
    @beds_ipd = if ward_param[:ward_type].present?
        Bed.get_vacant.where(ward_type: ward_param[:ward_type]).left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).as_json
      else
        Bed.get_vacant.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).uniq.as_json
      end
    render json: @beds_ipd, status: :ok
  end

  # GET /beds/all/acquired
  def get_acquired_beds_and_ipds
    if ward_param[:ward_type].present?
      @beds_ipd = Bed.get_acquired.where(ward_type: ward_param[:ward_type]).left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no).as_json
    else
      @beds_ipd = Bed.get_acquired.left_joins(:ipds).order(:ward_type).select(:id, :ward_type, :bed_no, :patient_id).as_json
    end
    render json: @beds_ipd, status: :ok
  end

  # GET /beds/ward_types
  # all ward types
  def get_ward_types
    render json: Bed::WARD_TYPES.as_json, status: :ok
  end

  private

  def set_bed
    @bed = Bed.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Bed Details not found" }, status: :not_found
  end

  def filtered_params
    params.permit(:status, :page, :ward_type) # Add permitted parameters here
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

  def authorize_bed
    authorize Bed
  end
end
