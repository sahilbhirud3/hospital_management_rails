require "rails_helper"

RSpec.describe AppointmentsController, type: :controller do
  let(:doctor_user) { create(:user) }
  let!(:doctor_detail) { create(:doctor_detail, user: doctor_user) }
  let!(:appointment) { create(:appointment, doctor: doctor_user) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:user) { create(:user) }
      let(:patient) { create(:patient) }
      let(:valid_params) do
        { user_id: user.id, patient_id: patient.id, doctor_id: doctor_user.id,
          slot_start_datetime: DateTime.now, slot_end_datetime: DateTime.now + 30.minutes,
          appointment_type: "checkup" }
      end

      it "creates a new appointment" do
        expect {
          post :create, params: valid_params
        }.to change(Appointment, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET #get_all_appointments_for_doctor" do
    it "returns a successful response and retrieves appointments for the doctor" do
      appointment1 = create(:appointment, doctor: doctor_user)
      appointment2 = create(:appointment, doctor: doctor_user)

      get :get_all_appointments_for_doctor, params: { doctor_id: doctor_user.id }
      expect(response).to be_successful
      appointments = JSON.parse(response.body)

      expect(appointments.length).to be > 1
    end
  end

  describe "GET #show" do
    it "returns a successful response and retrieves appointment" do
      get :show, params: { id: appointment.id }
      expect(response).to be_successful
    end
  end
end
