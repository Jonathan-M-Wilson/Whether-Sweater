Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/', to: 'welcome#index'
      resources :forecast, only: [:index]
      resources :background, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trip, only: [:create]
    end
  end
  get '/', to: redirect('/api/v1')
end
