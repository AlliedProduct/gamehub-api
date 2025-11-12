require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:library_items).dependent(:destroy) }

  it { should validate_presence_of(:title) }

  describe '#recalc_avg_rating!' do
    it 'updates avg_rating based on associated reviews' do
      game = create(:game, avg_rating: 0.0)
      create(:review, game: game, rating: 6)
      create(:review, game: game, rating: 9)

      game.recalc_avg_rating!
      expect(game.reload.avg_rating).to eq(7.5)
    end
  end
end
