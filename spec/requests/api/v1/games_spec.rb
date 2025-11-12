require 'rails_helper'

RSpec.describe "Games API", type: :request do
  let(:user) { create(:user) }

  describe "GET /api/v1/games" do
    it "returns a paginated list" do
      create_list(:game, 3)
      get "/api/v1/games"
      expect(response).to have_http_status(:ok)
      expect(json['data']).to be_an(Array)
      expect(json['data'].size).to be >= 1
      expect(json).to have_key('pagination')
    end
  end

  describe "POST /api/v1/games" do
    it "creates a game when authenticated" do
      headers = auth_headers_for(user, { 'Content-Type' => 'application/json' })
      payload = {
        game: {
          title: "Baldur's Gate 3",
          platform: "PC",
          genre: "RPG",
          release_year: 2023
        }
      }.to_json

      post "/api/v1/games", params: payload, headers: headers
      expect(response).to have_http_status(:created)
      expect(json['title']).to eq("Baldur's Gate 3")
    end

    it "rejects unauthenticated" do
      post "/api/v1/games", params: { game: { title: "Nope" } }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
