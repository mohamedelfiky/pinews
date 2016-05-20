require 'rails_helper'
require 'rack/test'

describe V1::ArticlesController do

  let(:article) { create(:article) }
  routes_for :article

  describe 'GET #index' do
    before { get articles_path }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'renders correct template' do
      is_expected.to render_template('articles/index')
    end

    it 'respects `page` param' do
      get articles_path, page: 2
      expect(json.size).to eq(0)
    end
  end

  describe 'GET #show' do
    before { get article_path }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'renders correct template' do
      is_expected.to render_template('articles/show')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before { post articles_path, { article: attributes_for(:article) }, user_header }

      it 'returns http `created`' do
        expect(response).to be_created
      end

      it 'renders correct template' do
        is_expected.to render_template('articles/show')
      end

      it 'assigns created article to current user' do
        expect(Article.last.author).to eq(user)
      end
    end

    context 'with invalid params' do
      before { post articles_path, { article: { title: '' } }, user_header }

      it 'returns unprocessable entity' do
        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end

    context 'without article object' do
      before { post articles_path, { title: '' }, user_header }

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
      it 'renders updated article' do
        put article_path, { article: attributes_for(:article) }, user_header

        is_expected.to render_template('articles/show')
      end
    end

    context 'with invalid params' do
      before { put article_path, { article: { description: '' } }, user_header }

      it 'returns unprocessable entity' do
        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete article_path, {}, user_header }

    it 'returns http no content' do
      expect(response).to have_http_status(:no_content)
    end

    it 'actually deletes article' do
      # ensure that private attributes aren't serialized
      expect(Article.find_by_id(article.id)).to eq(nil)
    end
  end
end
