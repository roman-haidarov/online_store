require 'rails_helper'

RSpec.describe ItemsController, type: :request do
  let!(:user) { create :user }
  let!(:basket) { create :basket, user: user }
  let!(:token) { TokensCreator.new(user).call }

  describe "POST /create" do
    context "when params is valid" do
      before do
        post "/items",
          { item: { name: "t_short", description: "very nice t short" } },
          "HTTP_AUTHORIZATION" => "Bearer #{token}"
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

    context "when params invalid" do
      before do
        post "/items",
          { item: { name: "t_short" } }, "HTTP_AUTHORIZATION" => "Bearer #{token}"
      end

      it "status bad request" do
        expect(last_response.status).to eq 400
      end

      it "return error message" do
        expect(json['errors']).to eq ["Description can't be blank"]
      end
    end
  end

  context "item is created" do
    let!(:item) { create :item }

    describe "POST /add_to_basket" do
      context "when params is valid" do
        before do
          post "/items/#{item.id}/add_to_basket",
            { bsket_item: { basket_id: basket.id, item_id: item.id } },
            "HTTP_AUTHORIZATION" => "Bearer #{token}"
        end
  
        it "status created" do
          expect(last_response.status).to eq 201
        end
  
        it "correct message" do
          expect(json['message']).to eq "item added to basekt"
        end
      end

      context "when params invalid" do
        let!(:basket) {}

        before do
          post "/items/#{item.id}/add_to_basket", {}, "HTTP_AUTHORIZATION" => "Bearer #{token}"
        end
  
        it "status created" do
          expect(last_response.status).to eq 400
        end
  
        it "return errors" do
          expect(json['errors']).to eq ["Basket must exist"]
        end
      end
    end

    describe "GET /index" do
      let!(:items) { create_list :item, 3 }

      before do
        get "/items"
      end

      it "status ok" do
        expect(last_response.status).to eq 200
      end

      it "return expected ids" do
        expect(json.pluck('id')).to eq Item.all.ids
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
        patch "/items/#{item.id}",
          { item: { name: "t_short", description: "very nice t short" } },
          "HTTP_AUTHORIZATION" => "Bearer #{token}"
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
        delete "/items/#{item.id}", {}, "HTTP_AUTHORIZATION" => "Bearer #{token}"

        expect(last_response.status).to eq 204
      end
    end
  end
end
