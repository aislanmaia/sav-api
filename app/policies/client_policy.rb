class ClientPolicy < ApplicationPolicy
  def can_list?
    admin? || attendant?
  end

  def can_edit?
    admin? || attendant?
  end

  def can_create?
    admin? || attendant?
  end

  def can_delete?
    admin? || attendant?
  end
end
