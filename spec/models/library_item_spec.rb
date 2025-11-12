require 'rails_helper'

RSpec.describe LibraryItem, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game) }

  it 'validates status inclusion' do
    item = build(:library_item, status: 'nonsense')
    expect(item).not_to be_valid
    expect(item.errors[:status]).to be_present
  end

  it 'enforces one library item per user/game pair' do
    user = create(:user)
    game = create(:game)
    create(:library_item, user: user, game: game, status: 'playing')
    dup = build(:library_item, user: user, game: game, status: 'completed')
    expect(dup).not_to be_valid
    expect(dup.errors[:game_id]).to include("has already been taken")
  end
end
