require 'rails_helper'
require 'rack/test'

describe 'Users API' do
  let(:user) { create(:user, :admin) }
  routes_for :user

  describe 'GET #index' do
    before { get users_path }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'renders correct template' do
      is_expected.to render_template('users/index')
    end

    it 'respects `page` param' do
      get users_path, page: 2
      expect(json.size).to eq(0)
    end
  end

  describe 'GET #show' do
    before { get user_path }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'renders correct template' do
      is_expected.to render_template('users/show')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before { post users_path, { user: attributes_for(:user, :admin) }, user_header }

      it 'returns http `created`' do
        expect(response).to be_created
      end

      it 'renders correct template' do
        is_expected.to render_template('users/show')
      end

    end

    context 'with invalid params' do
      before { post users_path, { user: { name: ''} }, user_header }

      it 'returns unprocessable entity' do
        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end

    context 'without user object' do
      before { post users_path, attributes_for(:user, :admin), user_header }

      it 'returns unprocessable entity' do
        expect(response).to be_bad_request
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'renders updated user' do
        put user_path, { user: attributes_for(:user) }, user_header

        is_expected.to render_template('users/show')
      end
    end

    context 'with invalid params' do
      before { put user_path, { user: { nickname: '' } }, user_header }

      it 'returns unprocessable entity' do
        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete user_path, {}, user_header }

    it 'returns http no content' do
      expect(response).to have_http_status(:no_content)
    end

    it 'actually deletes user' do
      # ensure that private attributes aren't serialized
      expect(User.find_by_id(user.id)).to eq(nil)
    end
  end
end
