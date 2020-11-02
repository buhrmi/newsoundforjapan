Rails.application.routes.draw do
  namespace :admin do
    resources :places
    resources :gigs
    resources :users
    resources :events
    root to: "users#index"
  end
  
  resources :events
  resources :places
  resources :gigs
  resource :session
  
  get '/auth/:provider/callback', to: 'sessions#create'
  
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
   
    get '/(:slug)', to: 'slugs#show'
    get '/talents/(:id)', to: 'users#show'
  end
  resources :users
  
  root to: 'gigs#index'
end
