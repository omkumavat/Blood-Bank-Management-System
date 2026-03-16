Rails.application.routes.draw do
  # devise_for :admins
  get "user_dashboard/index"
  # devise_for :blood_banks , path: 'blood_bank'
  # devise_for :hospitals, path: 'hospital'
  # devise_for :users, path: 'user'

  devise_for :users,
  path: "user",
  controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

devise_for :blood_banks,
  path: "blood-bank",
  controllers: {
    registrations: "blood_banks/registrations",
    sessions: "blood_banks/sessions"
  }

devise_for :hospitals,
  path: "hospital",
  controllers: {
    registrations: "hospitals/registrations",
    sessions: "hospitals/sessions"
  }

  devise_for :admins,
  path: "admin",
  controllers: {
    registrations: "admins/registrations",
    sessions: "admins/sessions"
  }

  get "/admin/dashboard", to: "admin_dashboard#dashboard", as: :admin_dashboard
  get "/admin/dashboard/blood-banks", to: "admin_dashboard#blood_banks", as: :manage_blood_banks
  patch "/admin/dashboard/blood-bank/:id", to: "admin_dashboard#verify_admin_blood_bank", as: :verify_admin_blood_bank
  get "/admin/dashboard/hospitals", to: "admin_dashboard#hospitals", as: :manage_hospitals
  patch "/admin/dashboard/hospital/:id", to: "admin_dashboard#verify_admin_hospital", as: :verify_admin_hospital

  get "/blood-bank/dashboard", to: "blood_bank_dashboard#dashboard", as: :blood_bank_dashboard
  get "/blood-bank/dashboard/donation-requests", to: "blood_bank_dashboard#donation_requests", as: :blood_bank_donation_requests
  patch "/blood-bank/dashboard/donation-requests/:appointment_id/:blood_bank_id/:blood_group", 
  to: "blood_bank_dashboard#accept_donation_appointment", as: :accept_donation_appointment
  get "/blood-bank/dashboard/blood-requests", to: "blood_bank_dashboard#blood_requests", as: :blood_bank_blood_requests
  get "/blood-bank/dashboard/blood-stocks", to: "blood_bank_dashboard#blood_stocks", as: :blood_bank_blood_stocks
  post "/blood-bank/dashboard/blood-stock/create", to: "blood_bank_dashboard#create_blood_stock", as: :blood_bank_create_blood_stock
  patch "/blood-bank/dashboard/blood-stock/update", to: "blood_bank_dashboard#update_blood_stock", as: :blood_bank_update_blood_stock

  get "/hospital/dashboard", to: "hospital_dashboard#dashboard", as: :hospital_dashboard
  get "/hospital/dashboard/blood-requests", to: "hospital_dashboard#blood_requests", as: :hospital_blood_requests
  get "/hospital/dashboard/blood-requests/new", to: "hospital_dashboard#blood_requests_form", as: :blood_request_form
  post "/hospital/dashboard/blood-requests", to: "hospital_dashboard#create_blood_request", as: :create_blood_request
  get "/hospital/dashboard/blood-bank", to: "hospital_dashboard#hospital_blood_bank", as: :manage_hospital_blood_bank
  post "/hospital/dashboard/blood-bank/blood-stock/create", to: "hospital_dashboard#create_blood_stock", as: :create_blood_stock
  patch "/hospital/dashboard/blood-bank/blood-stock/update", to: "hospital_dashboard#update_blood_stock", as: :update_blood_stock

  root "home#index", as: :home

  get "/user/dashboard", to: "user_dashboard#dashboard", as: :user_dashboard
  get "/user/dashboard/donate-blood", to: "user_dashboard#blood_banks", as: :user_donate_blood
  get "/user/dashboard/donate-blood/:id", to: "user_dashboard#show_blood_bank", as: :user_donate_blood_details
  post "/user/dashboard/donate-blood/:id/donate", to: "user_dashboard#create_donation_request", as: :user_create_donation_request
  get "/user/dashboard/donation-appointments", to: "user_dashboard#donation_appointments", as: :user_donation_appointments
  post "/user/dashboard/blood-request/:id/accept", to: "user_dashboard#accept_blood_request", as: :user_accept_blood_request
  get "/user/dashboard/accepted-blood-requests", to: "user_dashboard#accepted_blood_requests", as: :user_accepted_blood_requests



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
