Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  namespace :api do
    namespace :v1 do
      resources :articles do
        resources :photos
      end
    end
  end

  match '*path', to: 'application#not_found', via: :all
end
