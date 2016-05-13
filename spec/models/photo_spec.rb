require 'rails_helper'

RSpec.describe Photo, type: :model do

  subject(:photo){ build :photo }

  describe 'when title is not present' do
    before { photo.title = ' ' }
    it { is_expected.not_to be_valid }
  end

  describe 'when image is not present' do
    before { photo.image = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when all is present' do
    it { is_expected.to be_valid }
  end

end
