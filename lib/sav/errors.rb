module Sav
  module Errors
    class PermissionDenied < StandardError
      def problem
        'Permission denied'
      end

      def description
        'You haven\'t permission to execute this action'
      end
    end

    class RecordNotFound < StandardError
      def problem
        'Record not found'
      end

      def description
        'Record not found in database to perform the action'
      end
    end

    class RecordInvalid < StandardError
      def initialize(errors)
        super()
        @errors = errors
      end

      def problem
        'Record not valid'
      end

      def description
        "Validation error: #{@errors}"
      end
    end

  end
end
