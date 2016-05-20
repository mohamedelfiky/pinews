describe V1::ArticlesController do
  describe 'routing'  do

    it 'routes to #index' do
      expect(get(v1_articles_path)).to route_to('v1/articles#index')
    end

    it 'routes to #create' do
      expect(post(v1_articles_path)).to route_to('v1/articles#create')
    end

    it 'routes to #update' do
      expect(put(v1_article_path(1))).
        to route_to('v1/articles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete(v1_article_path(1))).
        to route_to('v1/articles#destroy', id: '1')
    end

    it 'routes to #show' do
      expect(get(v1_article_path(1))).
        to route_to('v1/articles#show', id: '1')
    end

    it 'routes to #not_found' do
      expect(put(v1_articles_path)).
        to route_to('application#not_found', path: 'api/v1/articles')
    end
  end
end
