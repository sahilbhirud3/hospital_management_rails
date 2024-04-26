require "rails_helper"

RSpec.describe IpdsController, type: :controller do
  let!(:patient) { create(:patient) }
  let!(:patient1) { create(:patient) }
  let!(:bed) { create(:bed) }
  let!(:bed1) { create(:bed) }
  let!(:department) { create(:department) }
  let!(:ipd) { create(:ipd, patient: patient, bed: bed, department: department) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:ipd_params) {
        {
          ipd: {
            patient_id: patient1.id,
            bed_id: bed1.id,
            department_id: department.id,
            treatment_description: "treatment description",
            admission_datetime: DateTime.now,
          },
        }
      }
      it "creates ipd" do
        post :create, params: ipd_params

        expect {
          response
        }.to change(Ipd, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
    context "with invalid parameters patient already registered" do
      let(:ipd_params) {
        {
          ipd: {
            patient_id: patient.id,
            bed_id: bed.id,
            department_id: department.id,
            treatment_description: "treatment description",
            admission_datetime: DateTime.now,
          },
        }
      }

      it "should not create a new IPD for an already admitted patient" do
        post :create, params: ipd_params

        expect {
          response
        }.not_to change(Ipd, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #discharged_ipd_patient" do
    context "with valid parameters" do
      it "discharges a patient" do
        put :discharged_ipd_patient, params: { id: ipd.id }
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
