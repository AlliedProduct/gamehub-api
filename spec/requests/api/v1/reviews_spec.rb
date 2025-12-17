require "rails_helper"

RSpec.describe "LibraryItems API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers_for(user, { "Content-Type" => "application/json" }) }

  describe "POST /api/v1/games" do
    it "adds a game to the user library with rating" do
      payload = {
        game: {
          title: "Minecraft",
          platform: "PS5",
          genre: "Sandbox",
          status: "completed",
          rating: 9
        }
      }.to_json

      post "/api/v1/games", params: payload, headers: headers

      expect(response).to have_http_status(:created)

      game = Game.last
      expect(game.avg_rating).to eq(9.0)
    end
  end

  describe "PUT /api/v1/games/:id" do
    it "updates rating and recalculates avg rating" do
      game = create(:game)
      create(:library_item, game: game, user: user, rating: 6)

      payload = { game: { rating: 8 } }.to_json

      put "/api/v1/games/#{game.id}", params: payload, headers: headers

      expect(response).to have_http_status(:ok)
      expect(game.reload.avg_rating).to eq(8.0)
    end
  end

  describe "authentication" do
    it "rejects unauthenticated access" do
      post "/api/v1/games", params: {}
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
