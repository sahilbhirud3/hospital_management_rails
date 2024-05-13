class AdminController < ApplicationController
  before_action :authenticate_admin

  def dashboard
    doctor_ids = Appointment.group(:doctor_id).count.keys
    users = User.where(id: doctor_ids).pluck(:id, :first_name, :last_name).index_by(&:first)

    @data = Appointment.group(:doctor_id).count.map do |id, count|
      user = users[id]
      ["Dr. #{user[1]} #{user[2]}", count]
    end

    @doctor_count = User.where(role: "doctor").count
    @vaccant_bed_count = Bed.where(status: "vaccant").count
    @appointment_count = Appointment.count
    @admitted_patient_count = Ipd.where(status: "admitted").count
  end

  private

  def authenticate_admin
    redirect_to root_path unless current_user.role == "admin"
  end
end
