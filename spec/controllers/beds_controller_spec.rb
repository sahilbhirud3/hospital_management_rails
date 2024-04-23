require "rails_helper"
RSpec.describe BedsController, type: :controller do
  before do
  end
  let(:bed) { create(:bed) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
      # puts "Response Body: #{response.body}"
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      # byebug
      expect {
        post :create, params: { bed: attributes_for(:bed) }
      }.to change(Bed, :count).by(1)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      bed = create(:bed)
      get :show, params: { id: bed.id }
      expect(response).to be_successful
    end
  end
  describe "PUT #update" do
    it "returns a successful response" do
      bed = create(:bed, status: "vaccant")
      put :update, params: { id: bed.id, bed: { status: "unavailable" } }
      # puts "response", response.body
      expect(response).to be_successful
    end
  end

  describe "GET #get_all_beds_and_ipds" do
    it "returns a successful response" do
      3.times do
        create(:bed)
      end
      get :get_all_beds_and_ipds
      expect(response).to be_successful
    end
  end
end
