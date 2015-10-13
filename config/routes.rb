Rails.application.routes.draw do

  root "graph#show"

  post '/users/:id/deals/' => 'deals#create', as: 'create_deal'
  get '/users/:id/deals/' => 'deals#new', as: 'new_deal'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/timeline' => 'timeline#show'

  get "users/:id" => "users#show", as: 'show_user'
  get "users/:id/edit" => "users#edit", as: 'edit_user'
  patch "users/:id/edit" => "users#update", as: 'update_user'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
end
