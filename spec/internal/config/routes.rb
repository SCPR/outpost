Rails.application.routes.draw do
  get '/people'       => 'people#index', as: :people
  get '/people/:id'   => 'people#show',  as: :person

  mount Outpost::Engine, at: 'outpost'

  namespace :outpost do
    resources :people
    get "*path" => 'errors#not_found'
  end
end
