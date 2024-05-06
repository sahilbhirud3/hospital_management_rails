class DepartmentsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :authorize_department, only: [:show, :edit, :update, :destroy]
  # GET /departments
  def index
    @departments = Department.all.order(:id).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.json { render json: @departments.as_json(only: [:id, :name, :address]), status: :ok }
      format.html
    end
  end

  #GET /department/:id/doctors
  #all doctors from particular(deptid) department
  def get_all_doctors
    @doctor_names = DoctorDetail.joins(:user, :department).where(department_id: params[:id]).pluck(:user_id, :first_name, :last_name)
    result = @doctor_names.map do |user_id, first_name, last_name|
      { id: user_id, first_name: first_name, last_name: last_name }
    end
    respond_to do |format|
      format.json { render json: result }
      format.html { @doctor_names }
    end
  end


  # GET /departments/1
  def show
    respond_to do |format|
      format.json { render json: @department.as_json(only: [:id, :name, :address]), status: :ok }
      format.html
    end
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: "Department was successfully created." }
        format.json { render json: { department: @department.as_json(only: [:id, :name, :address]), message: "Department successfully created." }, status: :created }
      else
        format.html do
          flash.now[:alert] = "Error: Department could not be created."
          render :new
        end
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: "Department was successfully updated." }
        format.json { render json: { department: @department.as_json(only: [:id, :name, :address]), message: "Department successfully updated." }, status: :ok }
      else
        format.html do
          flash.now[:alert] = "Error: Department could not be updated."
          render :edit
        end
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_path, notice: "Department was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_department
    @department = Department.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html do
        flash[:alert] = "Error: Department not found."
        redirect_to departments_path
      end
      format.json { render json: { error: "Department Not Found" }, status: :not_found }
    end
  end

  def department_params
    params.require(:department).permit(:name, :address)
  end

  def authorize_department
    authorize Department
  end
end
