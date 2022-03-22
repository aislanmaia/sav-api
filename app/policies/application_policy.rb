class ApplicationPolicy
  class UserError < StandardError; end

  def initialize(user)
    @user = user || raise(UserError)
  end

  def admin?
    @user.role == :admin
  end

  def attendant?
    @user.role == :attendant
  end

  def technician?
    @user.role == :technician
  end
end
