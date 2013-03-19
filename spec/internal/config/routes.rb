Rails.application.routes.draw do
  resources :people

  namespace :outpost do
    root to: 'home#index'
    resources :sessions, only: [:create, :destroy]
    get 'login'  => "sessions#new", as: :login
    get 'logout' => "sessions#destroy", as: :logout
  end
end
