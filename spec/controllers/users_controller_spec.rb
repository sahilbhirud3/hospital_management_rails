require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
      expect(response.body).to include(user.first_name)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_user_attributes) { attributes_for(:user) }

      it "creates a new user" do
        expect {
          post :create, params: { user: valid_user_attributes }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to include(valid_user_attributes[:first_name])
      end
    end

    # context "with doctor user" do
    #   let(:valid_doctor_user_attributes) { attributes_for(:doctor_user) }

    #   it "creates a new user" do
    #     expect {
    #       post :create, params: { user: valid_doctor_user_attributes }
    #     }.to change(User, :count).by(1)
    #     byebug
    #     expect(response).to have_http_status(:created)
    #     expect(response.body).to include(valid_doctor_user_attributes[:role])
    #   end
    # end

    context "with invalid parameters" do
      let(:invalid_user_attributes) { attributes_for(:user, email: nil) }

      it "does not create a new user" do
        expect {
          post :create, params: { user: invalid_user_attributes }
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
