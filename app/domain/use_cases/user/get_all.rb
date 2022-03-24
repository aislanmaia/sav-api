# frozen_string_literal: true

module UseCases
  module User
    class GetAll < Base
      def initialize(params, context: {})
        super(params, context)

        @user_repository = context.fetch(:user_repository) { ::Repositories::User.new }
      end

      def call
        can_perform_action?
        users = all_users
        success(users)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ActiveRecord::RecordNotFound => e
        failure({ error: e, code: 404 })
      end

      private

      def can_perform_action?
        user = @params[:user]
        user && policy(::User, user).can_list? || raise(::Sav::Errors::PermissionDenied)
      end

      def all_users
        @client_repository.all
      end
    end
  end
end
