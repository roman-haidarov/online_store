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
end