Checklist::Application.routes.draw do
  resources :tasks

  resources :users, only: [] do
    resources :tasks, path: '/', only: [:index]
  end

  match '/login'                 => redirect('/auth/twitter'), via: :get, as: :login
  match '/logout'                => 'sessions#destroy',        via: :get, as: :logout
  match '/auth/twitter/callback' => 'sessions#create',         via: :get

  root to: 'tasks#index'

end
