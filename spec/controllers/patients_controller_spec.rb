require "rails_helper"

RSpec.describe PatientsController, type: :controller do
  let(:patient_attributes) { attributes_for(:patient) }
  let!(:patient) { create(:patient) }

  describe "GET #index" do
    before { get :index }

    it "returns a successful response" do
      expect(response).to be_successful
    end

    it "returns the correct number of patients" do
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe "POST #create" do
    it "creates a new Patient" do
      expect {
        post :create, params: { patient: patient_attributes }
      }.to change(Patient, :count).by(1)
    end

    it "returns a 201 Created status" do
      post :create, params: { patient: patient_attributes }
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET #show" do
    context "with valid id" do
      it "returns a successful response" do
        get :show, params: { id: patient.id }
        expect(response).to be_successful
      end
    end

    context "with invalid id" do
      it "returns a 404 Not Found status" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET #get_all_patients_for_user" do
    context "with valid parameters" do
      it "returns a successful response" do
        get :get_all_patients_for_user, params: { user_id: patient.user_id }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "returns an empty response if no patients found" do
        get :get_all_patients_for_user, params: { user_id: 0 }
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to be_empty
      end
    end
  end
end
