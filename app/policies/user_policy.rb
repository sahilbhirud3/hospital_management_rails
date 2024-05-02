class UserPolicy < ApplicationPolicy
  def new_user?
    user.role == "admin"
  end

  def create_user?
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
    user.role == "admin"
  end
end
