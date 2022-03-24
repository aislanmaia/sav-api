module Repositories
  class User
    def initialize(scope = ::User)
      @scope = scope
    end

    def all
      @scope.all
    end
  end
end
