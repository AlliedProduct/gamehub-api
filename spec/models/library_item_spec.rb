require "rails_helper"

RSpec.describe LibraryItem, type: :model do
  subject { build(:library_item) }

  it { should belong_to(:user) }
  it { should belong_to(:game) }

  it { should validate_inclusion_of(:status).in_array(%w[playing completed on_hold dropped planning]).allow_nil }
  it { should validate_numericality_of(:rating).is_in(1..10).allow_nil }

  it { should validate_uniqueness_of(:game_id).scoped_to(:user_id) }

  it "recalculates game avg after save" do
    user = create(:user)
    game = create(:game)

    create(:library_item, user: user, game: game, rating: 8)

    expect(game.reload.avg_rating).to eq(8.0)
  end
end
