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
        department = create(:department)
        ipd = build(:ipd, patient_id: patient.id, bed_id: bed.id, department: department)

        expect {
        post :create, params:attributes_for(:ipd)
        }.to change(Appointment, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end
end
