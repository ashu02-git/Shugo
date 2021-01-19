Rails.application.routes.draw do
  root to: 'homes#top'
  # ユーザログイン機能のルーティング
  devise_for :users, skip: :all
  devise_scope :user do
    get 'users/sign_in' => 'users/sessions#new', as: 'new_user_session'
    post 'users/sign_in' => 'users/sessions#create', as: 'user_session'
    post 'users/guest_sign_in' => 'users/sessions#new_guest', as: 'new_guest_session'
    delete 'users/sign_out' => 'users/sessions#destroy', as: 'destroy_user_session'
    get 'users/sign_up' => 'users/registrations#new', as: 'new_user_registration'
    post 'users' => 'users/registrations#create', as: 'user_registration'
  end
  # 管理者ログイン機能のルーティング
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admins do
    resources :categories, only: [:create, :index, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end

  resources :users, only: [:index, :show, :edit, :update]
  patch 'users/:id/hide' => 'users#hide', as: 'user_hide'

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  get '/posts/hashtag/:name' => 'posts#hashtag'
  get '/search' => 'searches#search'
end
