=begin Rails.application.routes.draw do
  get "profile/new"
  get "categories/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # Defines the root path route ("/")
  # root "posts#index"
end
=end

Rails.application.routes.draw do
  root to: "articles#index"
  get "profile/manage", to: "profile#manage"
  get "profile/manage/user/:id", to: "profile#manage_user", as: "profile_manage_user"
  get "profile/new_user", to: "profile#new_user"
  devise_for :admins
  devise_for :users
  # get "/articles", to: "articles#index"
  # get "search/articles" to: "article#index"
  resources :categories, only: [] do
    resources :articles, only: [ :index ]
  end

  resources :articles, only: [ :index, :create, :new, :edit, :show, :destroy, :update ]
  resources :profile, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    member do
      post "change_user_author", to: "profile#change_user_author_toggle_button"
    end
  end
end
