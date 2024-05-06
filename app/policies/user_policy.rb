class UserPolicy < ApplicationPolicy
  def new_doctor_user?
    user.role == "admin"
  end

  def create_doctor_user?
    user.role == "admin"
  end

  def index?
    user.role == "admin"
  end

  def show?
    user.role == "admin"
  end

  def create?
    user.role == "admin"
  end

  def update?
    user.role == "admin"
  end

  def change_password?
    user.role == "admin"
  end

  def dashboard?
    user.role == "admin" || user.role == "user"
  end
end
