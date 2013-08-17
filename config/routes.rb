MemoRabble::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :memos, except: [:show]
  get '/memos/:token', to: 'memos#show'
  get '/inbox', to: 'users#inbox'

  match '/signup', to: 'users#new', via: 'get'

  # Static Pages:
  root 'static_pages#home'
  match '/signin',      to: 'sessions#new',             via: 'get'
  match '/signout',     to: 'sessions#destroy',         via: 'delete'
  match '/about',       to: 'static_pages#about',       via: 'get'
  match '/contribute',  to: 'static_pages#contribute',  via: 'get'
end
