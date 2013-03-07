Rails.application.routes.draw do
  namespace :outpost do
    root to: 'home#index'
    
    resources :sessions, only: [:create, :destroy]
    get 'login'  => "sessions#new", as: :login
    get 'logout' => "sessions#destroy", as: :logout

    get "/activity"                                        => "versions#activity",  as: :activity
    get "/:resources/:resource_id/history"                 => "versions#index",     as: :history
    get "/:resources/:resource_id/history/:version_number" => "versions#show",      as: :version
  end
end
