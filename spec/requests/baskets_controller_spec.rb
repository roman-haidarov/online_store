require 'rails_helper'

RSpec.describe BasketsController, type: :request do
  describe "GET /show" do
    let!(:user) { create :user }
    let!(:basket) { create :basket, user: user }
    let!(:items) { create_list :item, 2 }

    before do
      create :basket_item, basket: basket, item: items.first
      create :basket_item, basket: basket, item: items.second

      get "/baskets/#{basket.id}"
    end

    it "return status ok" do
      expect(last_response.status).to eq 200
    end

    it "return ids" do
      expect(json.pluck('id')).to eq items.pluck(:id)
    end
  end

  describe "POST /create" do
    let!(:user) { create :user }
    let!(:basket) { create :basket, user: user }
    let!(:items) { create_list :item, 2 }
    let!(:item) { create :item }

    before do
      create :basket_item, basket: basket, item: items.first
      create :basket_item, basket: basket, item: items.second
      create :basket_item, basket: basket, item: item
    end

    it "return status ok" do
      post "/baskets/#{basket.id}/create_order", { item_ids: [items.first.id, items.second.id] }

      expect(last_response.status).to eq 201
    end

    it "return expected data" do
      expect(basket.items.count).to eq 3

      post "/baskets/#{basket.id}/create_order", { item_ids: [items.first.id, items.second.id] }
      
      expect(basket.reload.items).to eq [item]
      expect(json['order_items'].pluck('id')).to eq items.pluck(:id)
    end
  end

  describe "DELETE /delete_from_basket" do
    let!(:user) { create :user }
    let!(:basket) { create :basket, user: user }
    let!(:item) { create :item }
    let!(:basket_item) { create :basket_item, basket: basket, item: item }


    before do
      delete "/baskets/#{basket.id}/delete_from_basket", { item_ids: [item.id] }
    end

    it "return status no content" do
      expect(last_response.status).to eq 204
    end

    it "return empty items" do
      expect(basket.items).to eq []
    end
  end
end