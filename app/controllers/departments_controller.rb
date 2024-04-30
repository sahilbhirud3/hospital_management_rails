class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update]

  # GET /departments
  def index
    @departments = Department.all

    respond_to do |format|
      format.json {render json: @departments.as_json(only: [:id, :name, :address]), status: :ok}
      format.html { @departments }
    end
  end

  # GET /departments/1
  def show
    render json: @department.as_json(only: [:id, :name, :address]), status: :ok
  end

  # POST /departments
  def create
    @department = Department.new(department_params)

    if @department.save
      render json: { department: @department.as_json(only: [:id, :name, :address]), message: "Department successfully created." }, status: :created
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # PUT /departments/1
  def update
    if @department.update(department_update_params)
      render json: { department: @department.as_json(only: [:id, :name, :address]), message: "Department successfully updated." }, status: :ok
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  private

  def set_department
    @department = Department.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Department Not Found" }, status: :not_found
  end

  def department_params
    params.require(:department).permit(:name, :address)
  end

  def department_update_params
    params.require(:department).permit(:address)
  end
end
