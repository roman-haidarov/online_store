class UserPolicy < ApplicationPolicy
  def show?
    admin_or_owner
  end

  def update?
    admin_or_owner
  end

  def destroy?
    user.admin
  end

  private

  def admin_or_owner
    admin? || record.user == user
  end
end
