Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  devise_for :users
  root 'homes#top'
  get 'about', to: 'homes#about'

  resources :posts
  resources :users, only: [:show, :edit, :update]

end
