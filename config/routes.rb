Rails.application.routes.draw do
  namespace :outpost do    
    resources :sessions, only: [:create, :destroy]
    get 'login'  => "sessions#new", as: :login
    get 'logout' => "sessions#destroy", as: :logout
  end
end
