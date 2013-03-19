Rails.application.routes.draw do
  resources :people

  namespace :outpost do
    root to: 'home#index'
  end
end
