require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  describe "POST /create" do
    before do
      post "/items", { item: { name: "t_short", description: "very nice t short" } }
    end

    it "status created" do
      expect(last_response.status).to eq 201
    end

    it "expected name" do
      expect(json['name']).to eq "t_short"
    end

    it "expected description" do
      expect(json['description']).to eq "very nice t short"
    end
  end

  context "item is created" do
    let!(:item) { create :item }

    describe "POST /add_to_basket" do
      let!(:current_user) { create :user }
      let!(:basket) { create :basket, user_id: current_user.id }

      before do
        post "/items/#{item.id}/add_to_basket?user_id=#{current_user.id}", { bsket_item: { basket_id: basket.id, item_id: item.id } }
      end

      it "status created" do
        expect(last_response.status).to eq 201
      end

      it "correct message" do
        expect(json['message']).to eq "item added to basekt"
      end
    end

    describe "GET /show" do
      before do
        get "/items/#{item.id}"
      end

      it "status ok" do
        expect(last_response.status).to eq 200
      end

      it "name is write" do
        expect(json['name']).to eq item.name
      end

      it "description is write" do
        expect(json['description']).to eq item.description
      end
    end

    describe "PATCH /update" do
      before do
        patch "/items/#{item.id}", { item: { name: "t_short", description: "very nice t short" } }
      end

      it "status ok" do
        expect(last_response.status).to eq 200
      end

      it "name is write" do
        expect(json['name']).to eq "t_short"
      end

      it "description is write" do
        expect(json['description']).to eq "very nice t short"
      end
    end

    describe "DELETE /destroy" do
      it "user delete" do
        delete "/items/#{item.id}"

        expect(last_response.status).to eq 204
      end
    end
  end
end