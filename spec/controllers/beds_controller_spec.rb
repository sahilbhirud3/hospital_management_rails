require "rails_helper"

RSpec.describe BedsController, type: :controller do
  describe "GET #index" do
    let!(:bed) { create(:bed) }
    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(bed.bed_no)
    end
  end

  describe "GET #show" do
    let(:bed) { create(:bed) }

    context "with valid id" do
      it "returns a success response" do
        get :show, params: { id: bed.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid id" do
      it "returns a not found response" do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    let(:valid_bed_params) do
      {
        bed: {
          ward_type: "ICU",
          bed_no: "ICU-01",
        },
      }
    end

    context "with valid parameters" do
      it "creates a new bed" do
        expect {
          post :create, params: valid_bed_params
        }.to change(Bed, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_bed_params) do
        {
          bed: {
            ward_type: "Invalid",
            bed_no: nil,
            status: "occupied",
          },
        }
      end

      it "does not create a new bed" do
        expect {
          post :create, params: invalid_bed_params
        }.to_not change(Bed, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    let(:bed) { create(:bed) }

    context "when bed status is not acquired" do
      it "updates the bed status" do
        put :update, params: { id: bed.id, bed: { status: "unavailable" } }
        expect(response).to have_http_status(:accepted)
      end
    end

    context "when bed status is acquired" do
      before { bed.update(status: "acquired") }

      it "returns an error" do
        put :update, params: { id: bed.id, bed: { status: "unavailable" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include("error" => "Currently Bed status is acquired..Discharge patient first")
      end
    end
  end

  describe "GET #get_ward_types" do
    it "returns all ward types" do
      get :get_ward_types
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to match(Bed::WARD_TYPES)
    end
  end
end
