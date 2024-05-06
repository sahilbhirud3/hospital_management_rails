class AppointmentPolicy < ApplicationPolicy
  def index?
    user.role == "admin" || user.role == "user" || user.role == "doctor"
  end

  def show?
    user.role == "admin"
  end

  def create?
    user.role == "admin" || user.role == "user"
  end

  def update?
    user.role == "admin"
  end

  def destroy?
    user.role == "admin"
  end

  def new?
    user.role == "admin" || user.role == "user"
  end

  def edit?
    user.role == "admin"
  end
end
