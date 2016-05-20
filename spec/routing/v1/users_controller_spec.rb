describe V1::UsersController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get(v1_users_path)).to route_to('v1/users#index')
    end

    it 'routes to #create' do
      expect(post(v1_users_path)).to route_to('v1/users#create')
    end

    it 'routes to #update' do
      expect(put(v1_user_path(1))).
        to route_to('v1/users#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete(v1_user_path(1))).
        to route_to('v1/users#destroy', id: '1')
    end

    it 'routes to #show' do
      expect(get(v1_user_path(1))).
        to route_to('v1/users#show', id: '1')
    end

    it 'routes to #not_found' do
      expect(put(v1_users_path)).
          to route_to('application#not_found', path: 'api/v1/users')
    end
  end
end
