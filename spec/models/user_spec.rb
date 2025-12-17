require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  it { should have_many(:library_items).dependent(:destroy) }
  it { should have_many(:games).through(:library_items) }
  it { should have_many(:reviews).dependent(:destroy) }

  it { should validate_presence_of(:username) }

it "validates username uniqueness (case-sensitive)" do
  create(:user, username: "testname", email: "a1@example.com")
  u2 = build(:user, username: "testname", email: "a2@example.com")

  expect(u2).not_to be_valid
  expect(u2.errors[:username]).to be_present
end
end
