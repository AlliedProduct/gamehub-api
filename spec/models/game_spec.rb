require "rails_helper"

RSpec.describe Game, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:reviews).dependent(:destroy) }

  it { should validate_presence_of(:title) }

  describe "#recalc_avg_rating!" do
    it "updates avg_rating based on associated reviews" do
      user = create(:user)
      game = create(:game, user: user)
      create(:review, game: game, user: user, rating: 10)
      create(:review, game: game, user: user, rating: 8)

      game.recalc_avg_rating!
      expect(game.reload.avg_rating).to eq(9.0)
    end
  end
end
