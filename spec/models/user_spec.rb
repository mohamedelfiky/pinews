require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Ability' do

    subject(:ability) { Ability.new(user) }
    let(:user) { build(:user, role) }

    context 'when is a Guest' do
      let(:role) { :guest }

      it { is_expected.to be_able_to(:read, build(:group)) }
      it { is_expected.not_to be_able_to(:cud, build(:group)) }
    end

    context 'when is a normal user' do
      let(:role) { :normal_user }
      let(:user_groups) { g = build(:group); g.update_attribute(:user_id, user.id); g }
      let(:other_groups) { g = build(:group); g.update_attribute(:user_id,  create(:user, :admin).id); g }

      it { is_expected.to be_able_to(:read_create, user_groups) }
      it { is_expected.to be_able_to(:update_destroy, user_groups) }
      it { is_expected.not_to be_able_to(:update_destroy, other_groups) }
    end


    context 'when is a admin' do
      let(:role) { :admin }
      it { is_expected.to be_able_to(:manage, build(:group)) }
    end

  end

end
