Rails.application.routes.draw do
  namespace :admin do
    resources :places
    resources :gigs
    resources :users
    resources :events
    namespace :ahoy do
      resources :visits
    end
    root to: "users#index"
  end
  
  resources :events
  resources :places
  resources :gigs
  resource :session
  resources :users
  resources :pages, controller: 'slugs'

  get '/auth/:provider/callback', to: 'sessions#create'
  
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get '/talents/(:id)', to: 'users#show'
  end
  
  get '/:twitter_name', to: 'users#show'
  
  root to: 'events#index'
end
