Rails.application.routes.draw do

  root  "graph#show"

  get   '/timeline' => 'timeline#show'

  get   "/graph/load_local_deals"
  post  "/graph/save_user_location"

  post  '/users/:id/create_deal/'   => 'deals#create',  as: 'create_deal'
  get   '/users/:id/create_deal/'   => 'deals#new',     as: 'new_deal'

  get     '/users/:id/deals'               => 'deals#show',    as: 'show_deals'
  get     '/users/:user_id/deals/:deal_id' => 'deals#edit',    as: 'edit_deal'
  patch   '/users/:user_id/deals/:deal_id' => 'deals#update',  as: 'update_deal'
  delete  '/users/:user_id/deals/:deal_id' => 'deals#destroy', as: 'delete_deal'

  get   '/signup' => 'users#new',    as: 'new_user'
  post  '/users'  => 'users#create', as: 'create_user'

  get   "/users/:id"      => "users#show",   as: 'show_user'
  get   "/users/:id/edit" => "users#edit",   as: 'edit_user'
  patch "/users/:id/edit" => "users#update", as: 'update_user'

  get   '/login'  => 'sessions#new'
  post  '/login'  => 'sessions#create'
  get   '/logout' => 'sessions#destroy'
  
end
