Rails.application.routes.draw do
  get '/people'       => 'people#index', as: :people
  get '/people/:id'   => 'people#show',  as: :person

  namespace :outpost do
    resources :people

    root to: 'home#dashboard'
    
    resources :sessions, only: [:create, :destroy]
    get 'login'  => "sessions#new", as: :login
    get 'logout' => "sessions#destroy", as: :logout

    get "*path" => 'errors#not_found'
  end
end
