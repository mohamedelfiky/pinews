require 'rails_helper'

describe 'photos API' do
  let(:article) { create(:article) }

  let(:photo) do
    article.photos << build(:photo)
    article.photos.first
  end
  routes_for :photo, parents: %i(article)


  describe 'GET #index' do
    before { get photos_path }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'respects `page` param' do
      get photos_path, page: 2
      expect(json.size).to eq(0)
    end
  end

  describe 'GET #show' do
    before { get photo_path }

    it 'returns http success' do
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before { post photos_path, { photo: attributes_for(:photo) }, user_header }

      it 'returns http `created`' do
        expect(response).to be_created
      end

      it 'assigns created photo to correct article' do
        expect(Photo.last.article).to eq(article)
      end
    end

    context 'with invalid params' do
      before { post photos_path, { photo: { title: '' } }, user_header }

      it 'returns unprocessable entity' do
        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end

    context 'without photo object' do
      before { post photos_path, { title: '' }, user_header }

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
      it 'renders updated photo' do
        put photo_path, { photo: attributes_for(:photo) }, user_header

        expect(json['title']).to eq(photo.title)
      end
    end

    context 'with invalid params' do
      before { put photo_path, { photo: { title: '' } }, user_header }

      it 'returns unprocessable entity' do
        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete photo_path, {}, user_header }

    it 'returns http no content' do
      expect(response).to have_http_status(:no_content)
    end

    it 'actually deletes photo' do
      # ensure that private attributes aren't serialized
      expect(Photo.find_by_id(photo.id)).to eq(nil)
    end
  end
end
