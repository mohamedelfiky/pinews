Rails.application.routes.draw do
  scope path: 'api/v1' do
    mount_devise_token_auth_for 'User', at: 'auth'
  end


  namespace :api do
    namespace :v1 do

      resources :groups

      resources :articles do
        resources :photos
      end

    end
  end

end
