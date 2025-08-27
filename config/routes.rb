Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/new'
  get 'groups/create'
  get 'groups/edit'
  get 'groups/update'
  get 'groups/destroy'
  root 'homes#top'
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { 
    registrations: "users/registrations"
  }

  get 'about', to: 'homes#about'
  resources :groups do
    member do
      post :join
      delete :leave
    end
  
    resources :group_posts, only: [:create, :destroy]
    resources :group_topics do
      resources :group_comments, only: :create
    end
  end
  
  resources :posts do
    resources :comments, only: [:create]
  end

  resources :users, only: [:show, :edit, :update]
end
