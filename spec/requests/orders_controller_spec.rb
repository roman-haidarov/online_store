require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  let!(:user) { create :user }
  let!(:token) { TokensCreator.new(user).call }

  describe "GET /index" do
    let!(:orders) { create_list :order, 3 }

    before do
      get "/orders", {}, "HTTP_AUTHORIZATION" => "Bearer #{token}"
    end

    it "return status ok" do
      expect(last_response.status).to eq 200
    end

    it "return expected data" do
      expect(json.pluck('id')).to eq orders.pluck(:id)
    end
  end

  describe "DELETE /destroy" do
    let!(:order) { create :order }

    before do
      delete "/orders/#{order.id}", {}, "HTTP_AUTHORIZATION" => "Bearer #{token}"
    end

    it "return status no content" do
      expect(last_response.status).to eq 204
    end
  end
end