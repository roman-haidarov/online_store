class OrderPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope if admin?
      user_id = scope.pluck(:user_id).uniq.first
      return [] unless user.id != user_id

      scope
    end
  end

  def destroy?
    admin?
  end
end
