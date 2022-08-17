Rails.application.routes.draw do
   devise_for :users,
    controllers: {
      registrations: :registrations,
      sessions: :sessions,
    }
  resources :cars, only: [:index, :create, :destroy] 
end
