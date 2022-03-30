module Repositories
  class User
    def initialize(scope = ::User)
      @scope = scope
    end

    def all
      @scope.all
    end

    def attendants
      @scope.where role: 2
    end

    def technicians
      @scope.where(role: 3)
    end

    def find_by_id(id)
      @scope.find id
    end
  end
end
