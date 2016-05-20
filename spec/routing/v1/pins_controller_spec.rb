describe V1::PinsController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get(v1_article_pins_path(article_id: 1))).
          to route_to('v1/pins#index', article_id: '1')
    end

    it 'routes to #create' do
      expect(post(v1_article_pins_path(article_id: 1))).
          to route_to('v1/pins#create', article_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete(v1_article_pin_path(article_id: 1, id: 1))).
          to route_to('v1/pins#destroy', article_id: '1', id: '1')
    end

    it 'routes to #count' do
      expect(get(count_v1_article_pins_path(article_id: 1))).
        to route_to('v1/pins#count', article_id: '1')
    end

    it 'routes to #not_found' do
      expect(get(v1_article_pin_path(article_id: 1, id: 1))).
        to route_to('application#not_found', path: 'api/v1/articles/1/pins/1')
    end

  end
end
