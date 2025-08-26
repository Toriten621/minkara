Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

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
