require "rails_helper"
RSpec.describe TreatmentsController, type: :controller do
  before do
    @ipd = create(:ipd)
    treatments = FactoryBot.create_list(:treatment, 5, ipd: @ipd)
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
end
