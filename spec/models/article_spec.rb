require 'rails_helper'

RSpec.describe Article, type: :model do
  subject(:article) { build :article }

  describe 'when title is not present' do
    before { article.title = ' ' }
    it { is_expected.not_to be_valid }
  end

  describe 'when description is not present' do
    before { article.description = ' ' }
    it { is_expected.not_to be_valid }
  end

  describe 'when author is not present' do
    before { article.author_id = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when all is present' do
    it { is_expected.to be_valid }
  end
end
