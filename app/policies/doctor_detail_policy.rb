class DoctorDetailPolicy < ApplicationPolicy
  def index?
    user.role == "admin"
  end

  def show?
    user.role == "admin" || user.role == "doctor"
  end

  def create?
    user.role == "admin"
  end

  def update?
    user.role == "admin" || user.role == "doctor"
  end

  def destroy?
    user.role == "admin"
  end

  def new?
    user.role == "admin"
  end

  def edit?
    user.role == "admin" || user.role == "doctor"
  end
end
