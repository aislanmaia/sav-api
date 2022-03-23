module Repositories
  class Client
    def initialize(scope = ::Client)
      @scope = scope
    end

    def all
      @scope.all
    end
  end
end
