require "rails_helper"

RSpec.describe DepartmentsController, type: :controller do
  let(:department) { create(:department) }
  let(:emergency_department) { create(:department, name: "Emergency") }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: department.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Department" do
        expect {
          post :create, params: { department: { name: "Gynaecology", address: "3rd floor" } }
        }.to change(Department, :count).by(1)
        expect(response).to be_successful
        expect(response.body).to include("Gynaecology")
      end
    end
    context "with invalid parameters" do
      it "does not create a new department" do
        expect {
          post :create, params: { department: { name: nil } }
        }.to_not change(Department, :count)

        # Check if the response status is unprocessable entity (422)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
