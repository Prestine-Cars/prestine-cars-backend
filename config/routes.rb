Rails.application.routes.draw do
  namespace :api do
    resources :reservations
  end
   devise_for :users,
    controllers: {
      registrations: :registrations,
      sessions: :sessions,
    }
end
