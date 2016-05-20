Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  scope :api do
    namespace :v1 do
      resources :users
      resources :articles do
        resources :photos
        resources :pins, only: %i(index create destroy) do
          get :count, on: :collection
        end
      end
    end
  end
  root to: redirect('/api/v1/articles')

  match '*path', to: 'application#not_found', via: :all
end
