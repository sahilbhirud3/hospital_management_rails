class AdminController < ApplicationController
  before_action :authenticate_admin

  def dashboard
    # Admin dashboard logic

    @data = { "2024-05-01" => 3, "2024-05-02" => 3, "2024-05-03" => 5 }
  end

  private

  def authenticate_admin
    redirect_to root_path unless current_user.role == "admin"
  end
end
