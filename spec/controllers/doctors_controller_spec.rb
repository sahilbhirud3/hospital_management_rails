require "rails_helper"

RSpec.describe DoctorsController, type: :controller do
  let!(:department) { create(:department) }

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

    context "with valid and invalid parameters" do
      it "creates a new doctor with valid parameter" do
        expect {
          post :create, params: valid_doctor_params
        }.to change(User, :count).by(1).and change(DoctorDetail, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      let(:invalid_doctor_params) do
        {
          user: {
            first_name: "sahil",
            last_name: "bhirud",
            email: "sahil@gmail.com", # This email is intentionally set to duplicate
            contact: "1234567890",    # This contact is intentionally set to duplicate
            password: "123",
            role: "doctor",
            doctor_detail_attributes: attributes_for(:doctor_detail, department_id: department.id),
          },
        }
      end

      it "does not create a new doctor with duplicate email and contact" do
        create(:user, email: "sahil@gmail.com", contact: "1234567890")
        expect {
          post :create, params: invalid_doctor_params
        }.to_not change(User, :count)

        # Expect the response to indicate failure due to uniqueness validation
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include("email" => ["has already been taken"], "contact" => ["has already been taken"])
      end

      context "invalid required time slot" do
        let(:invalid_doctor_params1) do
          {
            user: {
              first_name: "sahil",
              last_name: "bhirud",
              email: "sahil@gmail.com",
              contact: "1234567890",
              password: "123",
              role: "doctor",
              doctor_detail_attributes: attributes_for(:doctor_detail, required_time_slot: 25, department_id: department.id),
            },
          }
        end
        it "does not create a new doctor with invalid required_time_slot" do
          expect {
            post :create, params: invalid_doctor_params1
          }.to_not change(User, :count)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to include("doctor_detail.required_time_slot" => ["must be present and 10 or more like (15, 20, 30, 60)"])
        end
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
    context "with valid id" do
      let(:doctor) { create(:doctor_user) }
      it "returns a success response" do
        get :show, params: { id: doctor.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid id" do
      it "returns a not found response" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
