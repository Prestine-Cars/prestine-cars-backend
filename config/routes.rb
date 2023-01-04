Rails.application.routes.draw do 
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
   devise_for :users,
    controllers: {
      registrations: :registrations,
      sessions: :sessions,
    }
 
  namespace :api do
    namespace :v1 do 
      get 'reservations', to: 'reservations#index'
      resources :cities, only: [:index, :show, :create, :destroy] do
        resources :cars, only: [:create, :destroy] do
          resources :reservations, only: [:create, :destroy]
        end
      end
    end
  end
end
