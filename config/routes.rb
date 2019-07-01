require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'sites#index'
  mount Sidekiq::Web => '/sidekiq'

  resources :sites
end
