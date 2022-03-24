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
    admin? || attendant? && @user_repository.find_by_id(user_id).role != :admin
  end
end

