require 'rails_helper'

RSpec.describe Pin, type: :model do
  subject(:pin) { build :pin }

  describe 'when article_id is not present' do
    before { pin.article_id = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when user_id is not present' do
    before { pin.user_id = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when all is present' do
    it { is_expected.to be_valid }
  end
end
