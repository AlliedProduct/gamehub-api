require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game) }

  it { should validate_inclusion_of(:rating).in_range(1..10) }
  it { should validate_length_of(:comment).is_at_most(2000) }

  it 'recalculates game avg after create/update/destroy' do
    game = create(:game)
    create(:review, game: game, rating: 10)
    create(:review, game: game, rating: 4)
    expect(game.reload.avg_rating).to eq(7.0)
  end
end
