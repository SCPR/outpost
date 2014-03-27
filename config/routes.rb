Outpost::Engine.routes.draw do
  post 'sessions' => 'outpost/sessions#create'
  get 'login'  => "outpost/sessions#new", as: :login
  get 'logout' => "outpost/sessions#destroy", as: :logout

  root to: 'outpost/home#dashboard'
end
