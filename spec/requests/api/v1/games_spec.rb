require "rails_helper"

RSpec.describe Game, type: :model do
  it { should have_many(:library_items).dependent(:destroy) }
  it { should have_many(:users).through(:library_items) }

  it { should validate_presence_of(:title) }

  describe "#recalc_avg_rating!" do
    it "updates avg_rating based on library item ratings" do
      user1 = create(:user)
      user2 = create(:user)
      game = create(:game)

      create(:library_item, game: game, user: user1, rating: 10)
      create(:library_item, game: game, user: user2, rating: 8)

      game.recalc_avg_rating!

      expect(game.reload.avg_rating).to eq(9.0)
    end

    it "sets avg_rating to nil when no ratings exist" do
      game = create(:game)

      game.recalc_avg_rating!

      expect(game.reload.avg_rating).to be_nil
    end
  end
end
