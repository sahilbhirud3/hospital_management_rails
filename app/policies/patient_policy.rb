class PatientPolicy < ApplicationPolicy
  def index?
    user.role == "admin" || user.role == "user"
  end

  def show?
    user.role == "admin" || user.role == "user"
  end

  def create?
    user.role == "admin" || user.role == "user"
  end

  def update?
    user.role == "admin" || user.role == "user"
  end

  def new?
    user.role == "admin" || user.role == "user"
  end

  def edit?
    user.role == "admin" || user.role == "user"
  end
end
