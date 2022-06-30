class BasketPolicy < ApplicationPolicy
  def show?
    admin_or_user
  end

  def create_order?
    admin_or_user
  end

  def delete_from_basket?
    admin_or_user
  end

  private

  def admin_or_user
    admin? || record.user == user
  end
end
