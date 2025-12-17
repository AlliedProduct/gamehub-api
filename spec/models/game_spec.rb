require "rails_helper"

RSpec.describe Game, type: :model do
  it { should have_many(:library_items).dependent(:destroy) }
  it { should have_many(:users).through(:library_items) }

  it { should validate_presence_of(:title) }

  describe "#recalc_avg_rating_from_library_items!" do
    it "updates avg_rating based on library item ratings" do
      game = create(:game)
      user1 = create(:user)
      user2 = create(:user)

      create(:library_item, game: game, user: user1, rating: 10)
      create(:library_item, game: game, user: user2, rating: 8)

      game.recalc_avg_rating_from_library_items!

      expect(game.reload.avg_rating).to eq(9.0)
    end

    it "sets avg_rating to nil when no ratings exist" do
      game = create(:game)

    def game.recalc_avg_rating_from_library_items!
      avg = library_items.where.not(rating: nil).average(:rating)&.to_f
      update_column(:avg_rating, avg)
    end
      expect(game.reload.avg_rating).to be_nil
    end
  end
end
