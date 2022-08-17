Rails.application.routes.draw do 
   devise_for :users,
    controllers: {
      registrations: :registrations,
      sessions: :sessions,
    }
 
  namespace :api do
    resources :reservations
    namespace :v1 do
      resources :cities, only: [:index, :show, :create, :destroy]
    end
  end

  resources :cars, only: [:index, :create, :destroy] 

end
