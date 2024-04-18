class TreatmentsController < ApplicationController
  before_action :set_treatment, only: [:show]
  #GET /treatments
  def index
    @treatments = Treatment.all
    render json: @treatments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #POST /treatments
  def create
    @treatment = Treatment.new(treatment_params)
    if @treatment.save
      render json: { treatment: @treatment.as_json(except: [:created_at, :updated_at]), message: "Treatment Detail Added" }, status: :created
    else
      render json: @treatment.errors, status: :unprocessable_entity
    end
  end

  #GET /treatments/ipd/:ipd_id
  #get treatment records for specific ipd patient (ipd_id)
  def get_treatment_for_patient
    @treatments = Treatment.where(ipd_id: params[:ipd_id])
    render json: @treatments.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  #GET /treatments/:id
  def show
    render json: @treatment.as_json(except: [:created_at, :updated_at]), status: :ok
  end

  private

  def set_treatment
    @treatment = Treatment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Treatment Record not found" }, status: :not_found
  end

  def treatment_params
    params.require(:treatment).permit(:ipd_id, :description, :datetime)
  end
end
