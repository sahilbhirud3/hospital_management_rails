require "rails_helper"
RSpec.describe DepartmentsController, type: :controller do
  describe "GET #index" do
    context "when there are departments in the database" do
      let!(:department) { create(:department) }
      let!(:emergency_department) { create(:department, name: "Emergency") }
      it "returns a successful response" do
        get :index
        expect(response).to be_successful #successful response
        expect(assigns(:departments)).to match_array([department, emergency_department]) #exact match with existing data
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(2) #check size
      end
    end

    context "when there are no departments in the database" do
      it "returns a successful response" do
        get :index
        expect(response).to be_successful
        expect(assigns(:departments)).to eq([])
        json_response = JSON.parse(response.body)
        expect(json_response).to eq([])
      end
    end
  end

  describe "GET #show" do
    let!(:department) { create(:department) }
    context "with valid department id" do
      it "returns a successful response" do
        get :show, params: { id: department.id }
        expect(response).to be_successful
        expect(response.body).to include(department.name)
      end
    end

    context "with invalid department id" do
      it "returns a not found response" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("Department Not Found")
      end
    end
  end

  describe "POST #create" do
    let!(:emergency_department) { create(:department, name: "Emergency") }

    context "with valid params" do
      let(:valid_params) { { department: { name: "Gynaecology", address: "3rd floor" } } }

      it "creates a new Department" do
        expect {
          post :create, params: valid_params
        }.to change { Department.count }.by(1)
        expect(response).to be_successful
        expect(response.body).to include("Gynaecology")
        department = Department.last
        expect(department.name).to eq ("Gynaecology")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { department: { name: nil, address: "2nd floor" } } }

      it "does not create a new department" do
        expect {
          post :create, params: invalid_params
        }.to_not change(Department, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context "with duplicate department parameters" do
      let(:duplicate_params) { { department: { name: "Emergency", address: "2nd floor" } } }
      it "does not create a new department" do
        expect {
          post :create, params: duplicate_params
        }.to_not change(Department, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["name"]).to include("has already been taken")
      end
    end

    context "with missing department parameters" do
      let(:invalid_params) { { department: { address: "2nd floor" } } }

      it "does not create a new department" do
        expect {
          post :create, params: invalid_params
        }.to_not change(Department, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    let!(:department) { create(:department) }
    let(:new_address) { "3rd floor" }

    it "updates a Department" do
      put :update, params: { id: department.id, department: { address: new_address } }
      department.reload
      expect(response).to be_successful
      expect(Department.find(department.id).address).to eq("3rd floor")
      expect(department.address).to eq(new_address)
    end
    it "does not updates a Department because of invalid department id" do
      put :update, params: { id: 0, department: { address: new_address } }
      department.reload
      expect(response).to have_http_status(:not_found)
    end
  end
end
