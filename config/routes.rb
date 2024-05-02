Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  get "welcome/index"
  devise_for :users
  get "users/new_user", to: "users#new_user", as: :new_user
  post "users/create_user", to: "users#create_user", as: :create_user
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "welcome#index"
  post "/doctors", to: "doctors#create"
  get "/doctors", to: "doctors#index"
  get "/doctors/:id", to: "doctors#show", as: :show_doctors
  get "/doctors/department/:deptid", to: "doctors#get_all_doctors_from_department", as: :doctors_department
  get "/doctors/:id/availableslots", to: "doctors#todays_available_appointment_slot_for_doctor"

  get "/appointments/doctor/:doctor_id/all", to: "appointments#get_all_appointments_for_doctor"
  get "/appointments/doctor/:doctor_id/today", to: "appointments#get_todays_appointment_for_doctor"
  get "/appointments/user/:user_id", to: "appointments#get_all_appointments_for_user"
  put "/appointments/:id/cancel", to: "appointments#cancel_appointment"

  get "/treatments/ipd/:ipd_id", to: "treatments#get_treatments_for_ipd"
  get "/treatments/new/:ipd_id", to: "treatments#new", as: "new_ipd_treatment"
  delete "/treatments/:id", to: "treatments#destroy", as: "treatment_destroy"

  get "/ipds/admitted", to: "ipds#get_all_admitted_ipds"
  get "/ipds/ward/admitted", to: "ipds#get_all_admitted_ipds_from_ward"
  get "/ipds/ward", to: "ipds#get_all_ipds_from_ward"
  put "/ipds/discharge/:id", to: "ipds#discharged_ipd_patient", as: "discharge_ipd"
  get "/ipds/discharge/:id", to: "ipds#discharge", as: "view_discharge_ipd"

  # get "/beds/all", to: "beds#get_all_beds_and_ipds"
  # get "/beds/all/vaccant", to: "beds#get_vaccant_beds"
  # get "/beds/all/acquired", to: "beds#get_acquired_beds_and_ipds"
  get "/beds/ward_types", to: "beds#get_ward_types"

  get "/patients/user/:user_id", to: "patients#get_all_patients_for_user"

  put "/users/:id/change_password", to: "users#change_password"

  # For user dashboard
  get "/user_dashboard", to: "users#dashboard", as: "user_dashboard"

  # For admin dashboard
  get "/admin_dashboard", to: "admin#dashboard", as: "admin_dashboard"

  # For doctor dashboard
  get "/doctor_dashboard", to: "doctors#dashboard", as: "doctor_dashboard"

  resources :departments
  resources :patients
  resources :users
  resources :beds do
    member do
      patch "toggle_status"
    end
  end
  resources :appointments
  resources :ipds
  resources :treatments
end
