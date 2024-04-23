require "rails_helper"

RSpec.describe IpdsController, type: :controller do
  before do
    @patient = create(:patient)
    @bed = create(:bed)
    @department = create(:department)
    @ipd = create(:ipd, patient_id: @patient.id, bed_id: @bed.id, department: @department)
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
        patient = create(:patient)
        bed = create(:bed)
        # ipd = build(:ipd, patient_id: patient.id, bed_id: bed.id, department_id: @department.id)

        expect {
          post :create, params: { ipd: { patient_id: patient.id, bed_id: bed.id, department_id: @department.id, treatment_description: "treatment description", admission_datetime: DateTime.now } }
        }.to change(Ipd, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "PUT #discharged_ipd_patient" do
    context "with valid parameters" do
      it "discharge patient" do
        put :discharged_ipd_patient, params: { id: @ipd.id }
        expect(response).to have_http_status(:accepted)
      end
    end
  end

  describe "GET #get_all_admitted_ipds" do
    it "returns a successful response" do
      get :get_all_admitted_ipds
      expect(response).to be_successful
    end
  end
end
