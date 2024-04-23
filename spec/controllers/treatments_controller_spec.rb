require "rails_helper"
RSpec.describe TreatmentsController, type: :controller do
  before do
    @patient = create(:patient)
    @bed = create(:bed)
    @department = create(:department)
    @ipd = create(:ipd, patient_id: @patient.id, bed_id: @bed.id, department: @department)
  end

  describe "GET #index" do
    it "returns a successful response" do
      create(:treatment, ipd_id: @ipd.id) # Create a treatment
      get :index
      expect(response).to be_successful
      # puts "Response Body: #{response.body}"
    end
  end

  describe "POST #create" do
    it "creates a new treatment" do
      expect {
        post :create, params: { treatment: { ipd_id: @ipd.id, description: "test description", datetime: DateTime.now } }
      }.to change(Treatment, :count).by(1)
      # puts "Response Body: #{response.body}"
    end
  end

  describe " #create" do
    it "creates a new treatment" do
      # byebug
      expect {
        post :create, params: { treatment: { ipd_id: @ipd.id, description: "test description", datetime: DateTime.now } }
      }.to change(Treatment, :count).by(1)
      # puts "Response Body: #{response.body}"
    end
  end
end
