Rails.application.routes.draw do
  resources :places
  resources :events
  resources :gigs
  namespace :admin do
    resources :users

    root to: "users#index"
  end
  
  resource :session
  
  get '/auth/:provider/callback', to: 'sessions#create'
  
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
   
    get '/(:slug)', to: 'slugs#show'
    get '/talents/(:name)', to: 'users#show'
  end
  resources :users
  
  root to: 'gigs#index'
end
