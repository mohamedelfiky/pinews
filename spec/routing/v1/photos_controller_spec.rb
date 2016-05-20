describe V1::PhotosController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get(v1_article_photos_path(article_id: 1)))
          .to route_to('v1/photos#index', article_id: '1')
    end

    it 'routes to #create' do
      expect(post(v1_article_photos_path(article_id: 1)))
          .to route_to('v1/photos#create', article_id: '1')
    end

    it 'routes to #update' do
      expect(put(v1_article_photo_path(article_id: 1, id: 1))).
        to route_to('v1/photos#update', id: '1', article_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete(v1_article_photo_path(article_id: 1, id: 1))).
        to route_to('v1/photos#destroy', id: '1', article_id: '1')
    end

    it 'routes to #show' do
      expect(get(v1_article_photo_path(article_id: 1, id: 1))).
        to route_to('v1/photos#show', id: '1', article_id: '1')
    end

    it 'routes to #not_found' do
      expect(put(v1_article_photos_path(article_id: 1))).
          to route_to('application#not_found', path: 'api/v1/articles/1/photos')
    end
  end
end
