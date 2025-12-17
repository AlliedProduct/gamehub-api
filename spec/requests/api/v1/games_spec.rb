require "rails_helper"

RSpec.describe "Games API", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET /api/v1/games" do
    it "rejects unauthenticated" do
      get "/api/v1/games"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns only the current user's games when authenticated" do
      create_list(:game, 2, user: user)
      create_list(:game, 3, user: other_user)

      headers = auth_headers_for(user)
      get "/api/v1/games", headers: headers

      expect(response).to have_http_status(:ok)

      expect(json).to be_an(Array)
      expect(json.length).to eq(2)

      expect(json.all? { |g| g["user_id"] == user.id }).to be(true)
    end
  end

  describe "POST /api/v1/games" do
    it "creates a game for the current user when authenticated" do
      headers = auth_headers_for(user, { "Content-Type" => "application/json" })

      payload = {
        game: {
          title: "Baldur's Gate 3",
          platform: "PC",
          genre: "RPG",
          status: "completed",
          rating: 9
        }
      }.to_json

      post "/api/v1/games", params: payload, headers: headers

      expect(response).to have_http_status(:created)
      expect(json["title"]).to eq("Baldur's Gate 3")
      expect(json["user_id"]).to eq(user.id)
      expect(json["status"]).to eq("completed")
      expect(json["rating"]).to eq(9)
    end

    it "rejects unauthenticated" do
      post "/api/v1/games", params: { game: { title: "Nope" } }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT /api/v1/games/:id" do
    it "prevents updating another user's game" do
      game = create(:game, user: other_user)

      headers = auth_headers_for(user, { "Content-Type" => "application/json" })
      payload = { game: { title: "Hacked" } }.to_json

      put "/api/v1/games/#{game.id}", params: payload, headers: headers

      expect(response).to have_http_status(:not_found).or have_http_status(:unauthorized)
    end
  end
end
