Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit' 
  get 'users/update' 

  devise_for :users, controllers: { 
    registrations: "users/registrations"
  }

  root 'homes#top'
  get 'about', to: 'homes#about'

  resources :posts do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show, :edit, :update]
end
