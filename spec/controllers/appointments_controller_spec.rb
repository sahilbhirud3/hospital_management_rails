require "rails_helper"

RSpec.describe AppointmentsController, type: :controller do
  before do
    @doctor_user = create(:user)
    create(:doctor_detail, user_id: @doctor_user.id)
    @appointment = create(:appointment, doctor: @doctor_user)
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new appointment" do
        user = create(:user)
        patient = create(:patient)

        expect {
          post :create, params: { user_id: user.id, patient_id: patient.id, doctor_id: @doctor_user.id, slot_start_datetime: DateTime.now, slot_end_datetime: DateTime.now + 30.minutes, appointment_type: "checkup" }
        }.to change(Appointment, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET #get_all_appointments_for_doctor" do
    context "with valid parameters" do
      it "returns a successful response and retrieves appointments for the doctor" do
        appointment1 = create(:appointment, doctor: @doctor_user)
        appointment2 = create(:appointment, doctor: @doctor_user)

        get :get_all_appointments_for_doctor, params: { doctor_id: @doctor_user.id }
        expect(response).to be_successful
        appointments = JSON.parse(response.body)

        expect(appointments.length).to be > 1
      end
    end
  end

  describe "GET #show" do
    it "returns a successful response and retrieves appointment" do
      get :show, params: { id: @appointment.id }
      puts response.body
      expect(response).to be_successful
    end
  end
end
