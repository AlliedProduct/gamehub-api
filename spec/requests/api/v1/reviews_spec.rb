require 'rails_helper'

RSpec.describe "Reviews API", type: :request do
  let(:user) { create(:user) }
  let(:game) { create(:game) }

  describe "POST /api/v1/games/:game_id/reviews" do
    it "creates a review when authenticated" do
      headers = auth_headers_for(user, { 'Content-Type' => 'application/json' })
      payload = { review: { rating: 9, comment: "Fantastic!" } }.to_json

      post "/api/v1/games/#{game.id}/reviews", params: payload, headers: headers
      expect(response).to have_http_status(:created)
      expect(json['rating']).to eq(9)
      expect(game.reload.avg_rating).to eq(9.0)
    end

    it "rejects unauthenticated" do
      post "/api/v1/games/#{game.id}/reviews", params: { review: { rating: 9 } }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
