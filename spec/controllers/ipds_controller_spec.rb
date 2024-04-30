require "rails_helper"

RSpec.describe IpdsController, type: :controller do
  let!(:patient) { create(:patient) }
  let!(:patient1) { create(:patient) }
  let!(:bed) { create(:bed) }
  let!(:bed1) { create(:bed,ward_type:"ICU") }
  let!(:department) { create(:department) }
  let!(:ipd) { create(:ipd, patient: patient, bed: bed, department: department) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    context "with filters" do
      it "returns a successful response with status filter" do
        get :index, params: { status: "admitted" }
        expect(response).to be_successful
        expect(response.body).to include("admitted")
      end
      it "returns a successful response with status filter" do
        ipd = create(:ipd, status: "discharged")
        get :index, params: { status: "discharged" }
        expect(response).to be_successful
        expect(response.body).to include("discharged")
      end

      it "returns a successful response with department_id filter" do
        department1 = create(:department)
        ipd = create(:ipd, department: department1)
        get :index, params: { department_id: department.id }
        expect(response).to be_successful

      end

      it "returns a successful response with ward_type filter" do
        ipd = create(:ipd,bed:bed1)
        get :index, params: { ward_type: "ICU" }
        expect(response).to be_successful
        expect(response.body).to include("ICU")
      end
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
        expect {
          post :create, params: ipd_params
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
