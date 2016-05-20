require 'rails_helper'

describe 'Article Pins API' do
  let(:article) { create(:article) }
  let(:pin) { Pin.create(article_id: article.id, user_id: user.id) }

  routes_for :pin, parents: %i(article)

  describe 'GET #index' do
    before { get pins_path }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'renders correct template' do
      is_expected.to render_template('pins/index')
    end

    it 'respects `page` param' do
      get pins_path, page: 2
      expect(json.size).to eq(0)
    end
  end

  describe 'GET #count' do
    before { get pins_path + 'count' }

    it 'returns http success' do
      expect(response).to be_success
    end

    it 'count all pins for an article' do
      expect(json['count']).to eq(article.pins.count)
    end
  end

  describe 'POST #create' do
    before { post pins_path, {}, user_header }

    it 'returns http `created`' do
      expect(response).to be_created
    end

    it 'assigns created pin to current article' do
      expect(Pin.last.article).to eq(article)
    end

    describe 'pin article more than once' do
      it 'returns unprocessable entity ' do
        post pins_path, {}, user_header

        expect(response).to be_unprocessable
      end

      it 'returns JSON with errors' do
        post pins_path, {}, user_header

        expect(json['errors']).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete pin_path, {}, user_header }

    it 'returns http no content' do
      expect(response).to have_http_status(:no_content)
    end

    it 'actually deletes article' do
      # ensure that private attributes aren't serialized
      expect(Pin.find_by_id(pin.id)).to eq(nil)
    end
  end
end
