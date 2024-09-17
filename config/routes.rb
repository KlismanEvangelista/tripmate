Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # plans
  get 'my_plans', to: 'plans#my_plans', as: :my_plans
  resources :plans do
    resources :travels, only: %i[create]
    resources :messages, only: %i[new create]
  end
  # patch 'plans/:id/travels/', to: 'travels#rejected'
  # travels
  get 'my_requests', to: 'travels#my_requests', as: :my_requests
  get 'my_travels', to: 'travels#my_travels', as: :my_travels
  get 'my_reviews', to: 'reviews#my_reviews', as: :my_reviews

  # Reviews routes
  resources :travels, except: %i[new create] do
    resources :reviews, only: %i[new create]
  end

  resources :users do
    resources :reviews, only: %i[index show]
  end

  resources :reviews, only: %i[index edit update destroy]
end
