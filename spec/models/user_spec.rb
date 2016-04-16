require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Ability' do

    subject(:ability) { Ability.new(user) }
    let(:user) { build(:user, role) }

    context 'when is a Guest' do
      let(:role) { :guest }

      it { is_expected.to be_able_to(:read, build(:article)) }
      it { is_expected.not_to be_able_to(:cud, build(:article)) }
    end

    context 'when is an author' do
      let(:role) { :author }
      let(:my_article) { g = build(:article); g.update_attribute(:author_id, user.id); g }
      let(:my_photo) { my_article.photos << FactoryGirl.build(:photo) }
      let(:others_article) { g = build(:article); g.update_attribute(:author_id,  create(:user, :admin).id); g }
      let(:others_photo) { others_article.photos << FactoryGirl.build(:photo) }

      it { is_expected.to be_able_to(:read_create, my_article) }
      it { is_expected.to be_able_to(:update_destroy, my_article) }
      it { is_expected.not_to be_able_to(:update_destroy, others_article) }

      it { is_expected.to be_able_to(:update_destroy, my_photo.first) }
      it { is_expected.not_to be_able_to(:update_destroy, others_photo.first) }
    end

    context 'when is a admin' do
      let(:role) { :admin }
      it { is_expected.to be_able_to(:manage, build(:article)) }
    end
  end

end
