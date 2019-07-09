require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'sites#index'
  mount Sidekiq::Web => '/sidekiq'

  resources :sites do
    post :update_info
    
    resources :pages, shallow: true
  end
end
