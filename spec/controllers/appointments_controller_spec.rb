require "rails_helper"

RSpec.describe AppointmentsController, type: :controller do
  let(:doctor_user) { create(:user) }
  let!(:doctor_detail) { create(:doctor_detail, user: doctor_user) }
  let!(:appointment) { create(:appointment, doctor: doctor_user) }
  let!(:ipd) { create(:ipd) }
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
      expect(response.body).to include(appointment.id.to_s)
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }
    let(:user1) { create(:user) }
    let(:patient) { create(:patient) }
    let(:patient1) { create(:patient) }
    # let!(:appointment) { create(:appointment) }
    datetime = DateTime.now
    let!(:valid_params) do
      { user_id: user.id, patient_id: patient.id, doctor_id: doctor_user.id,
        slot_start_datetime: datetime, slot_end_datetime: datetime + 30.minutes,
        appointment_type: "checkup" }
    end
    let!(:invalid_params1) do
      { user_id: user1.id, patient_id: appointment.patient_id, doctor_id: appointment.doctor_id,
        slot_start_datetime: appointment.slot_start_datetime, slot_end_datetime: appointment.slot_end_datetime,
        appointment_type: "checkup" }
    end
    let!(:invalid_params2) do
      { user_id: user1.id, patient_id: ipd.patient_id, doctor_id: doctor_user.id,
        slot_start_datetime: datetime, slot_end_datetime: datetime,
        appointment_type: "checkup" }
    end
    let!(:invalid_params3) do
      { user_id: user1.id, patient_id: patient1.id, doctor_id: doctor_user.id,
        slot_start_datetime: appointment.slot_start_datetime.strftime("%Y-%m-%d %H:%M"), slot_end_datetime: appointment.slot_end_datetime,
        appointment_type: "checkup" }
    end

    context "with valid parameters" do
      it "creates a new appointment" do
        expect {
          post :create, params: valid_params
        }.to change(Appointment, :count).by(1)
        expect(response).to have_http_status(:created)
      end
      it "does not create a new appointment for patient who is admitted" do
        expect {
          post :create, params: invalid_params2
        }.to_not change(Appointment, :count)
        expect(JSON.parse(response.body)).to include("error" => "Patient is already admitted")
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "does not create a new appointment for already booked appointment" do
        expect {
          post :create, params: invalid_params3
        }.to_not change(Appointment, :count)
        # puts response.body
        expect(JSON.parse(response.body)).to include("error" => "Appointment not available for the given doctor")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid user parameters" do
      let(:invalid_params) { valid_params.merge(user_id: 0) }

      it "does not create a new appointment" do
        expect {
          post :create, params: invalid_params
        }.to_not change(Appointment, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #cancel_appointment" do
    it "updates status as cancelled" do
      put :cancel_appointment, params: { id: appointment.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Appointment Cancelled")
    end
  end

  describe "GET #show" do
    context "with valid id" do
      it "returns a successful response and retrieves appointment" do
        get :show, params: { id: appointment.id }
        expect(response).to be_successful
      end
    end

    context "with invalid id" do
      it "returns an unsuccessful response" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
