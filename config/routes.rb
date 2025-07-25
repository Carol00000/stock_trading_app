Rails.application.routes.draw do
  get "portfolios/show"
  devise_for :users, defaults: { format: :html }

  root "home#index"

  namespace :admin do
    resources :users do 
      member do
        patch :approve  #creates a route to approve a user (/admin/users/:id/approve)
        delete :deny #creates a route to deny a user (/admin/users/:id/deny)
      end
    end
    resources :transactions #standard RESTful routes for transactions in the admin area
  end

  resources :transactions  #public routes; accessible to regular users

  resources :stocks, only: [:create] do
    collection do
      get :intraday
      put :update_stock, to: "stocks#update"
    end
  end

  #get "stocks/intraday"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
end
