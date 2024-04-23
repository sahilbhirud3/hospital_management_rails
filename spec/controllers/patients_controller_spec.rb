require "rails_helper"

RSpec.describe PatientsController, type: :controller do
  let(:patient_attributes) { attributes_for(:patient) }

  describe "GET #index" do
    before do
      create(:patient) # Create a patient using FactoryBot
      get :index
    end

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
end
