# spec/controllers/doctors_controller_spec.rb
require "rails_helper"

RSpec.describe DoctorsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #get_all_doctors_from_department" do
    it "returns a success response" do
      department = create(:department)
      get :get_all_doctors_from_department, params: { deptid: department.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            first_name: "sahil",
            last_name: "bhirud",
            email: "sahil@gmail.com",
            contact: "1234567890",
            password: "123",
            role: "doctor",
            doctor_detail_attributes: {
              regno: "123",
              department_id: create(:department).id,
              start_time: "09:00",
              end_time: "17:00",
              required_time_slot: 30,
              qualification: "MD",
            },
          },
        }
      end

      it "creates a new doctor" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1).and change(DoctorDetail, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET #todays_available_appointment_slot_for_doctor" do
    it "returns a success response" do
      doctor = create(:user, role: "doctor")
      create(:doctor_detail, user_id: doctor.id)
      get :todays_available_appointment_slot_for_doctor, params: { id: doctor.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      doctor = create(:user, role: "doctor")
      create(:doctor_detail, user_id: doctor.id)
      get :show, params: { id: doctor.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
