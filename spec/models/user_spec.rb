require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:library_items).dependent(:destroy) }
  it { should have_many(:games).through(:library_items) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
end
