class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update]

  # GET /departments
  def index
    @departments = Department.all
    render json: @departments.as_json(only: [:id, :name, :address]), status: :ok
  end

  # GET /departments/1
  def show
    if @department
      render json: @department.as_json(only: [:id, :name, :address]), status: :ok
    else
      render json: { message: "Department Not Found" }, status: :bad_request
    end
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
    if @department.update(department_params)
      render json: { department: @department.as_json(only: [:id, :name, :address]), message: "Department successfully updated." }, status: :ok
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :address)
  end
end
