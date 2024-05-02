class BedPolicy < ApplicationPolicy
  def index?
    user.role == "admin"
  end

  def get_all_beds_and_ipds
    user.role == "admin"
  end

  def get_vacant_beds
    user.role == "admin"
  end

  def get_acquired_beds_and_ipds
    user.role == "admin"
  end

  def get_ward_types
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

  def destroy?
    user.role == "admin"
  end

  def new?
    user.role == "admin"
  end

  def edit?
    user.role == "admin"
  end
end
