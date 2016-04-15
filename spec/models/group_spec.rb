require 'rails_helper'
RSpec.describe Group, type: :model do

  subject(:group){  FactoryGirl.build :group }

  describe 'when name is not present' do
    before { group.name = ' ' }
    it { is_expected.not_to be_valid }
  end

  describe 'when name is present' do
    it { is_expected.to be_valid }
  end

end
