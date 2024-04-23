require "rails_helper"
RSpec.describe UsersController, type: :controller do
  before do
  end

  describe "GET #index" do
    it "returns a successful response" do
      user = create(:user) # Create a user using FactoryBot
      # create(:user)
      get :index
      puts "User GET#index Tested"
      expect(response).to be_successful
      puts "Response Body: #{response.body}"
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      # byebug
      expect {
        post :create, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(1)
      puts "User GET#index Tested"
      # puts "Request Body: #{attributes_for(:user)}"
      # puts "Response Body: #{response.body}"
    end
  end
end
