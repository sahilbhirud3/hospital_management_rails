require "rails_helper"
RSpec.describe DoctorsController, type: :controller do
  let(:department) { create(:department) }

  let(:valid_doctor_params) do
    {
      user: {
        first_name: "sahil",
        last_name: "bhirud",
        email: "sahil@gmail.com",
        contact: "1234567890",
        password: "123",
        role: "doctor",
        doctor_detail_attributes: attributes_for(:doctor_detail, department_id: department.id),
      },
    }
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #get_all_doctors_from_department" do
    it "returns a success response" do
      get :get_all_doctors_from_department, params: { deptid: department.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new doctor" do
        expect {
          post :create, params: valid_doctor_params
        }.to change(User, :count).by(1).and change(DoctorDetail, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET #todays_available_appointment_slot_for_doctor" do
    it "returns a success response" do
      doctor = create(:doctor_user)
      get :todays_available_appointment_slot_for_doctor, params: { id: doctor.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      doctor = create(:doctor_user)
      get :show, params: { id: doctor.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
