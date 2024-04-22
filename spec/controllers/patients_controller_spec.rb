require "rails_helper"
RSpec.describe PatientsController, type: :controller do
  before do
  end

  describe "GET #index" do
    it "returns a successful response" do
      create(:patient) # Create a patient using FactoryBot
      get :index
      expect(response).to be_successful
      # puts "Response Body: #{response.body}"
    end
  end

  describe "POST #create" do
    it "creates a new Patient" do
      # byebug
      expect {
        post :create, params: { patient: attributes_for(:patient) }
      }.to change(Patient, :count).by(1)
      # puts "Request Body: #{attributes_for(:patient)}"
      # puts "Response Body: #{response.body}"
    end
  end
end
