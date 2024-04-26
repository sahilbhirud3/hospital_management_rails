require "rails_helper"
RSpec.describe TreatmentsController, type: :controller do
  before do
    @ipd = create(:ipd)
    @treatments = FactoryBot.create_list(:treatment, 5, ipd: @ipd)
  end

  describe "GET #index" do
    it "returns a successful response" do
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

  describe "GET #show" do
    it "show treatment" do
      get :show, params: { id: @treatments[0].id }
      expect(response).to be_successful
    end
  end

  describe "GET #get treatments for ipd" do
    it "get treatment for ipd" do
      get :get_treatments_for_ipd, params: { ipd_id: @ipd.id }
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(5)
    end
  end
  describe "DELETE #destroy" do
    it "deletes treatments" do
      delete :destroy, params: { id: @treatments[0].id }
      expect(response).to be_successful
      body = JSON.parse(response.body)
      expect(body["message"]).to include("Treatment Deleted Successfully")
    end
  end
end
