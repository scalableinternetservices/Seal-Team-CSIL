Rails.application.routes.draw do

  root "home#show"

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get "users/:id" => "users#show", as: 'show_user'
  get "users/:id/edit" => "users#edit", as: 'edit_user'
  patch "users/:id/edit" => "users#update", as: 'update_user'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
end
