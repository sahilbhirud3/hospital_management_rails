class TreatmentsController < ApplicationController
  before_action :set_treatment, only: [:show, :destroy]
  before_action :authenticate_user!
  before_action :authorize_treatment
  # GET /treatments
  def index
    @treatments = Treatment.all.order(datetime: :desc).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @treatments.as_json(except: [:created_at, :updated_at]), status: :ok }
    end
  end

  # GET /treatments/new
  def new
    @treatment = Treatment.new
    @ipd = Ipd.find(params[:ipd_id])
  end

  # POST /treatments
  def create
    ipd = Ipd.find_by_id(treatment_params[:ipd_id])
    if ipd.nil?
      flash.now[:alert] = "Error: IPD not found"
      respond_to do |format|
        format.html { redirect_to ipds_path }
        format.json { render json: { error: "IPD not found" }, status: :not_found }
      end
      return
    elsif ipd.status == "discharged"
      flash.now[:alert] = "Error: IPD patient is already discharged"
      respond_to do |format|
        format.html { redirect_to ipd_path(ipd) }
        format.json { render json: { error: "IPD patient is already discharged" }, status: :unprocessable_entity }
      end
      return
    end

    @treatment = Treatment.new(treatment_params)
    respond_to do |format|
      if @treatment.save
        format.html do
          flash[:notice] = "Treatment detail added successfully"
          redirect_to ipd_path(ipd)
        end
        format.json { render json: { treatment: @treatment.as_json(except: [:created_at, :updated_at]), message: "Treatment detail added" }, status: :created }
      else
        format.html { render :new }
        format.json { render json: @treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /treatments/ipd/:ipd_id
  # Get treatment records for a specific IPD patient (ipd_id)
  def get_treatments_for_ipd
    @treatments = Treatment.where(ipd_id: params[:ipd_id]).order(datetime: :desc)

    respond_to do |format|
      format.html { render :index } # Render the same index view as HTML
      format.json { render json: @treatments.as_json(except: [:created_at, :updated_at]), status: :ok }
    end
  end

  # GET /treatments/:id
  def show
    respond_to do |format|
      format.html # Render HTML template
      format.json { render json: @treatment.as_json(except: [:created_at, :updated_at]), status: :ok }
    end
  end

  # DELETE /treatments/:id
  def destroy
    @treatment.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = "Treatment deleted successfully"
        redirect_to ipds_path
      end
      format.json { render json: { message: "Treatment deleted successfully" }, status: :ok }
    end
  end

  private

  def set_treatment
    @treatment = Treatment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html do
        flash[:alert] = "Treatment record not found"
        redirect_to treatments_url
      end
      format.json { render json: { error: "Treatment record not found" }, status: :not_found }
    end
  end

  def treatment_params
    params.require(:treatment).permit(:ipd_id, :description, :datetime)
  end

  def authorize_treatment
    authorize Treatment
  end
end
