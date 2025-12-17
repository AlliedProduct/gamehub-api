require "rails_helper"

RSpec.describe "LibraryItems API", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers_for(user, { "Content-Type" => "application/json" }) }

  it "creates a library item via POST /api/v1/games" do
    post "/api/v1/games",
      params: { game: { title: "Minecraft", platform: "PS5", status: "playing", rating: 9 } }.to_json,
      headers: headers

    expect(response).to have_http_status(:created)
  end

  it "updates rating via PUT /api/v1/games/:id and recalculates avg" do
    game = create(:game)
    create(:library_item, user: user, game: game, rating: 6)

    put "/api/v1/games/#{game.id}",
      params: { game: { rating: 8 } }.to_json,
      headers: headers

    expect(response).to have_http_status(:ok)
    expect(game.reload.avg_rating).to eq(8.0)
  end
end
