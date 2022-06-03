require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "POST /create" do
    before do
      post "/users", { user: { email: "test@mail.ru", password: "123456" } }
    end

    it "status created" do
      expect(last_response.status).to eq 201
    end

    it "checked that the email is correct" do
      expect(json['email']).to eq User.last.email
    end

    it "checked that the user has basket" do
      expect(User.last.basket.persisted?).to eq true
    end
  end

  context "user is created" do
    let(:user) { create :user }

    describe "GET /show" do
      before do
        get "/users/#{user.id}"
      end

      it "status ok" do
        expect(last_response.status).to eq 200
      end

      it "email is write" do
        expect(json['email']).to eq user.email
      end
    end

    describe "PATCH /update" do
      before do
        patch "/users/#{user.id}", { user: { email: "test@mail.ru", password: "123456" } }
      end

      it "status ok" do
        expect(last_response.status).to eq 200
      end

      it "email is write" do
        expect(json['email']).to eq "test@mail.ru"
      end
    end

    describe "DELETE /destroy" do
      it "user delete" do
        delete "/users/#{user.id}"

        expect(last_response.status).to eq 204
      end
    end
  end
end