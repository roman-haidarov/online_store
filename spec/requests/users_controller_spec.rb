require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "POST /create" do
    it "created user" do
      post "/users", { user: { email: "test@mail.ru", password: "123456" } }

      expect(last_response.status).to eq 201
      expect(json['email']).to eq User.last.email
      expect(User.last.basket.persisted?).to eq true
    end
  end
end