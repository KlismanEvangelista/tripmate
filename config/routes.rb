Rails.application.routes.draw do
=begin
  get 'plans/index'
  get 'plans/new'
  get 'plans/create'
  get 'plans/show'
  get 'plans/edit'
  get 'plans/update'
  get 'plans/destroy'
=end
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # plans
  get 'plans/my_plans', to: 'plans#my_plans', as: :my_plans
  resources :plans do
    resources :travels, shallow: true do
      member do
        patch :status
      end
    end
  end
  # patch 'plans/:id/travels/status', to: 'travels#change_status'
  # travels
  get 'travels/my_travels', to: 'travels#my_travels'
  # Reviews routes
  resources :travels, except: %i[new create] do
    resources :reviews, only: %i[new create]
  end

  resources :users do
    resources :reviews, only: %i[index show]
  end

  resources :reviews, only: %i[index edit update destroy]
end
