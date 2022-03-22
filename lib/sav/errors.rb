module Save
  module Errors
    class PermissionDenied < StandardError
      def problem
        'Permission denied'
      end

      def description
        'You haven\'t permission to execute this action'
      end
    end
  end
end
