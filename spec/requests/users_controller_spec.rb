require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "GET /show" do
    let(:user) { create :user }

    it "user created" do
      get "/users/#{user.id}"

      expect(last_response.status).to eq 200
      expect(json['email']).to eq user.email
    end
  end

  describe "POST /create" do
    it "created user" do
      post "/users", { user: { email: "test@mail.ru", password: "123456" } }

      expect(last_response.status).to eq 201
      expect(json['email']).to eq User.last.email
      expect(User.last.basket.persisted?).to eq true
    end
  end

  describe "PATCH /update" do
    let(:user) { create :user }

    it "user updated" do
      patch "/users/#{user.id}", { user: { email: "test@mail.ru", password: "123456" } }

      expect(last_response.status).to eq 200
      expect(json['email'] != user.email).to eq true
    end
  end

  describe "DELETE /destroy" do
    let(:user) { create :user }

    it "user delete" do
      delete "/users/#{user.id}"

      expect(last_response.status).to eq 204
    end
  end
end