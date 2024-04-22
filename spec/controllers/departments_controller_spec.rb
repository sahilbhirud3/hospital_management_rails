require "rails_helper"

RSpec.describe DepartmentsController, type: :controller do
  before do
    create(:department)
    @department = create(:department, name: "Emergency")
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "returns all departments" do
      get :index
      expect(assigns(:departments).count).to eq(2)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: @department.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new Department" do
      expect {
        post :create, params: { department: { name: "Gynaecology", address: "3rd floor" } }
      }.to change(Department, :count).by(1)
      # puts response.body
    end
  end
end
