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
        users = all_users_by_scope
        success(users)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ActiveRecord::RecordNotFound => e
        failure({ error: e, code: 404 })
      end

      private

      def can_perform_action?
        user = @params[:user]
        user && policy(::User, user).can_list?
      end

      def admin?
        user = @params[:user]
        policy(::User, user).admin?
      end

      def attendant?
        user = @params[:user]
        policy(::User, user).attendant?
      end

      def all_users_by_scope
        return @user_repository.all if admin?
        return @user_repository.attendants.or(@user_repository.technicians) if attendant?

        raise(::Sav::Errors::PermissionDenied)
      end
    end
  end
end
