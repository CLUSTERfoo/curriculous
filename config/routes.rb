MemoRabble::Application.routes.draw do
  # Users
  resources :users, except: [:show]
  get 'users/:username', to: 'users#show'

  get '/inbox', to: 'users#inbox'
  match '/signup', to: 'users#new', via: 'get'

  # Sessions
  resources :sessions, only: [:new, :create, :destroy]
  match '/signin',      to: 'sessions#new',             via: 'get'
  match '/signout',     to: 'sessions#destroy',         via: 'delete'

  # Memos
  resources :memos, except: [:show]
  get 'memos/:token/replies', to: 'memos#replies', as: 'memo_replies', constraints: { format: 'js' }
  get '/memos/:token', to: 'memos#show'



  # Static Pages:
  root 'static_pages#home'
  match '/about',       to: 'static_pages#about',       via: 'get'
end
