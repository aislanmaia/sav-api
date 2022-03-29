class UserPolicy < ApplicationPolicy
  def initialize(user, context = {})
    super(user)
    @user_repository = context.fetch(:user_repository) { ::Repositories::User.new }
  end

  def can_list?
    admin? || attendant?
  end

  def can_edit?
    admin? || attendant?
  end

  def can_create?
    admin? || attendant?
  end

  def can_update?(user_id)
    admin? || attendant? && @user_repository.find_by_id(user_id).role != :admin
  end

  def can_delete?(user_id)
    user_target = @user_repository.find_by_id(user_id)
    not_himself?(user_id) && (admin? || attendant? && user_target.role != :admin)
  end

  def himself?(user_id)
    @user == @user_repository.find_by_id(user_id)
  end

  def not_himself?(user_id)
    !himself? user_id
  end
end

