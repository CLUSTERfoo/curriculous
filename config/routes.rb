MemoRabble::Application.routes.draw do
  resources :users

  match '/signup', to: 'users#new', via: 'get'

  # Static Pages:
  root 'static_pages#home'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contribute', to: 'static_pages#contribute', via: 'get'
end
