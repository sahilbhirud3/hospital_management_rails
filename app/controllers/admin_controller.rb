class AdminController < ApplicationController
  before_action :authenticate_admin

  def dashboard
    # Admin dashboard logic
  end

  private
    def authenticate_admin
      redirect_to root_path unless current_user.role == "admin"
    end
end
