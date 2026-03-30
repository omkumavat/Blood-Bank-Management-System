Rails.application.routes.draw do

  devise_for :users,       path: "user",       controllers: { registrations: "users/registrations",       sessions: "users/sessions" }
  devise_for :blood_banks, path: "blood-bank", controllers: { registrations: "blood_banks/registrations", sessions: "blood_banks/sessions" }
  devise_for :hospitals,   path: "hospital",   controllers: { registrations: "hospitals/registrations",   sessions: "hospitals/sessions" }
  devise_for :admins,      path: "admin",      controllers: { registrations: "admins/registrations",      sessions: "admins/sessions" }

  root "home#index", as: :home
  post "/home/set-theme", to: "home#set_theme", as: :set_theme

  namespace :admin do
    get "dashboard", to: "dashboard#index", as: :dashboard

    resources :blood_banks, path: "blood-bank", only: [:index] do
      patch :verify, on: :member
    end

    resources :hospitals, only: [:index] do
      patch :verify, on: :member
    end
  end

#   get "/debug-credentials", to: proc { |env|
#   client_id = Rails.application.credentials.dig(:google, :client_id)
#   client_secret = Rails.application.credentials.dig(:google, :client_secret)
#   [200, {"Content-Type" => "text/plain"}, ["client_id: #{client_id}", "client_secret: #{client_secret}"]]
# }

  namespace :blood_bank, path: "blood-bank" do
    get "dashboard", to: "dashboard#index", as: :dashboard

    resources :donation_appointments, path: "donation-appointments", only: [:index] do
      # member do
      #   patch :accept
      # end
      patch :accept, on: :member
    end

    resources :blood_stocks, only: [:index, :create, :update, :edit, :new], path: "blood-stocks"

    resources :blood_requests, only: [:index, :show],  path: "blood-requests" 

    # resources :blood_stocks, only: [:index, :create, :update]
  end

  namespace :hospital do
    get "dashboard", to: "dashboard#index", as: :dashboard

    resources :blood_requests, only: [:index, :new, :create, :show],  path: "blood-requests" 

    resources :blood_banks, only: [:index], path: "blood-bank" do
      resources :blood_stocks, only: [:create, :update, :edit, :new], path: "blood-stocks"
    end
  end

  namespace :user do
    get "dashboard", to: "dashboard#index", as: :dashboard

    resources :blood_banks, only: [:index], path: "blood-bank"

    resources :donation_appointments, only: [:index, :new, :create],  path: "donation-appointments"

    resources :blood_requests, only: [:index, :show], path: "blood-requests" do
      patch :accept, on: :member
      get :accepted, on: :collection
    end

  end

  # get '/auth/:provider/redirect', to: 'oauth#redirect'
  # get '/auth/callback', to: 'oauth#callback'

  get  "/auth/google",    to: "oauth_user#redirect",  as: :google_auth
  devise_scope :user do
    get  "/auth/callback",  to: "users/sessions#oauth_callback"
  end
  delete "/auth/signout", to: "oauth_user#signout", as: :signout
  get  "/complete-profile",     to: "users/profiles#complete",         as: :complete_profile
  patch "/complete-profile",    to: "users/profiles#update_profile",   as: :update_profile

  get "up" => "rails/health#show", as: :rails_health_check
end