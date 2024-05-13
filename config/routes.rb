# == Route Map
#

Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  root "welcome#index"
  get "welcome/index"
  # Admin dashboard route
  get "/admin_dashboard", to: "admin#dashboard", as: "admin_dashboard"

  #devise
  devise_for :users

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  #Doctors resource
  resources :doctors, only: [:create, :index, :show, :edit, :update] do
    member do
      get :availableslots, to: "doctors#todays_available_appointment_slot_for_doctor"
    end
    collection do
      get "dashboard", to: "doctors#dashboard"
    end
    resources :appointments
  end

  # Department resource
  resources :departments do
    member do
      get :get_all_doctors
    end
  end

  # Routes for patients and users
  resources :patients

  #users
  resources :users do
    member do
      put :change_password
      # get :appointments, to: "appointments#get_all_appointments_for_user"
    end
    resources :appointments
    resources :patients
    collection do
      get :dashboard, to: "users#dashboard"
      get :new_doctor, to: "users#new_doctor_user"
      post :create_doctor, to: "users#create_doctor_user"
    end
  end

  # Additional routes
  resources :beds do
    member do
      patch :toggle_status
    end
    collection do
      get :ward_types, to: "beds#get_ward_types"
    end
  end

  # nested routes for treatments
  resources :ipds do
    member do
      put :update_discharge
      get :edit_discharge
      # get :generate_pdf

    end
    resources :treatments, only: [:index, :new, :destroy, :create]
  end

  # Routes for appointments
  resources :appointments do
    member do
      patch :update_status
      put :cancel, to: "appointments#cancel_appointment"
    end
  end
end
