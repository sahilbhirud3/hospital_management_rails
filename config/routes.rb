Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post "/doctors", to: "doctors#create"
  get "/doctors", to: "doctors#index"
  get "/doctors/:id", to: "doctors#show"
  get "/doctors/department/:deptid", to: "doctors#get_all_doctors_from_department"
  get "/doctors/:id/availableslots", to: "doctors#todays_available_appointment_slot_for_doctor"

  get "/appointments/doctor/:doctor_id/all", to: "appointments#get_all_appointments_for_doctor"
  get "/appointments/doctor/:doctor_id/today", to: "appointments#get_todays_appointment_for_doctor"

  get "/treatments/ipd/:ipd_id", to: "treatments#get_treatments_for_ipd"

  get "/ipds/admitted", to: "ipds#get_all_admitted_ipds"
  get "/ipds/ward/admitted", to: "ipds#get_all_admitted_ipds_from_ward"
  get "/ipds/ward", to: "ipds#get_all_ipds_from_ward"
  put "/ipds/discharge/:id", to: "ipds#discharged_ipd_patient"

  get "/beds/all", to: "beds#get_all_beds_and_ipds"
  get "/beds/all/vaccant", to: "beds#get_vaccant_beds"
  get "/beds/all/acquired", to: "beds#get_acquired_beds_and_ipds"

  get "/patients/user/:user_id", to: "patients#get_all_patients_for_user"
  resources :departments
  resources :patients
  resources :users
  resources :beds
  resources :appointments
  resources :ipds
  resources :treatments
end
