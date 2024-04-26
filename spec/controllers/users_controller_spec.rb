require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  describe "GET #index" do
    it "returns a successful response with users" do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to match_array([user.as_json({ only: [:id, :first_name, :last_name, :email, :contact, :role] })])
    end
  end

  describe "GET #show" do
    context "with valid user id" do
      it "returns the user details" do
        get :show, params: { id: user.id }
        expect(response).to be_successful
        expect(response.body).to include(user.first_name)
      end
    end

    context "with invalid user id" do
      it "returns a not found response" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_user_params) { attributes_for(:user) }

      it "creates a new user" do
        expect {
          post :create, params: { user: valid_user_params }
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.body).to include(valid_user_params[:first_name])
      end
    end

    context "with invalid parameters" do
      let!(:existing_user) { create(:user) }

      it "does not create a new user with duplicate email" do
        invalid_user_params = attributes_for(:user, email: existing_user.email)
        expect {
          post :create, params: { user: invalid_user_params }
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a new user with duplicate contact" do
        invalid_user_params = attributes_for(:user, contact: existing_user.contact)
        expect {
          post :create, params: { user: invalid_user_params }
        }.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "creates user with default role even if provided invalid role" do
        invalid_user_params = attributes_for(:user, role: "doctor")
        expect {
          post :create, params: { user: invalid_user_params }
        }.to change(User, :count).by(1)

        expect(User.last.role).to eq("user")
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "PUT #update" do
    let(:user) { create(:user) }

    context "with valid params" do
      let(:valid_params) { { id: user.id, first_name: "Newfirstname", last_name: "Newlastname" } }

      it "updates the user" do
        put :update, params: valid_params
        user.reload
        expect(user.first_name).to eq("Newfirstname")
        expect(user.last_name).to eq("Newlastname")
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user is not found" do
      it "returns a not_found response" do
        put :update, params: { id: "invalid_id", user: { first_name: "Newfirstname", last_name: "Newlastname" } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PUT #change_password" do
    let(:user) { create(:user) }

    context "with valid old password and new password" do
      let(:valid_params) { { id: user.id, old_password: "123", new_password: "1234" } }

      it "changes the user password" do
        put :change_password, params: valid_params
        user.reload
        expect(user.authenticate("1234")).to be_truthy
      end

      it "returns a success response" do
        put :change_password, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid old password" do
      let(:invalid_params) { { id: user.id, old_password: "invalid_password", new_password: "new_password" } }

      it "does not change the user password" do
        put :change_password, params: invalid_params
        user.reload
        expect(user.authenticate("new_password")).to be_falsy
      end

      it "returns an unprocessable_entity response" do
        put :change_password, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user is not found" do
      it "returns a not_found response" do
        put :change_password, params: { id: "invalid_id", old_password: "old_password", new_password: "new_password" }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
