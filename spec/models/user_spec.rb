require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Ability' do
    subject(:ability) { Ability.new(user) }
    let(:user) { build(:user, role) }

    context 'when is a Guest' do
      let(:role) { nil }

      it { is_expected.to be_able_to(:read, build(:article)) }
      it { is_expected.to be_able_to(:read, build(:photo)) }
      it { is_expected.to be_able_to(:count, build(:pin)) }
      it { is_expected.not_to be_able_to(:cud, build(:article)) }
      it { is_expected.not_to be_able_to(:cud, build(:photo)) }
      it { is_expected.not_to be_able_to(:cud, build(:user)) }
    end

    context 'when is an author' do
      let(:role) { :author }
      let(:my_article) do
        g = build(:article)
        g.update_attribute(:author_id, user.id)
        g
      end
      let(:my_photo) { my_article.photos << FactoryGirl.build(:photo) }
      let(:others_article) do
        g = build(:article)
        g.update_attribute(:author_id, create(:user, :admin).id)
        g
      end
      let(:others_photo) { others_article.photos << FactoryGirl.build(:photo) }

      let(:my_pin) do
        p = create(:pin)
        p.update_attribute(:user_id, user.id)
        p
      end
      let(:others_pin) { build(:user, :author) }

      it { is_expected.to be_able_to(:read_create, my_article) }
      it { is_expected.to be_able_to(:update_destroy, my_article) }
      it { is_expected.not_to be_able_to(:update_destroy, others_article) }

      it { is_expected.to be_able_to(:update_destroy, my_photo.first) }
      it { is_expected.not_to be_able_to(:update_destroy, others_photo.first) }

      it { is_expected.to be_able_to(:read, user) }
      it { is_expected.not_to be_able_to(:cud, build(:user, :author)) }

      it { is_expected.to be_able_to(:create, build(:pin)) }
      it { is_expected.to be_able_to(:destroy, my_pin) }
      it { is_expected.not_to be_able_to(:destroy, others_pin) }
    end

    context 'when is a admin' do
      let(:role) { :admin }
      it { is_expected.to be_able_to(:manage, build(:article)) }
      it { is_expected.to be_able_to(:manage, build(:user, :author)) }
      it { is_expected.to be_able_to(:manage, build(:pin)) }
    end
  end
end
