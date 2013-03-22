Rails.application.routes.draw do
  get '/people'       => 'people#index', as: :people
  get '/people/:id'   => 'people#show',  as: :person

  namespace :outpost do
    resources :people
  end
end
