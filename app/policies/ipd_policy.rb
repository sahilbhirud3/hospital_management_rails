class IpdPolicy < ApplicationPolicy
  def index?
    user.role == "admin"
  end

  def show?
    user.role == "admin"
  end

  def create?
    user.role == "admin"
  end

  def destroy?
    user.role == "admin"
  end

  def edit_discharge?
    user.role == "admin"
  end

  def update_discharge?
    user.role == "admin"
  end

  def new?
    user.role == "admin"
  end
end
