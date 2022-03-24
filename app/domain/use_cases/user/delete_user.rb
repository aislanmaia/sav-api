# frozen_string_literal: true

module UseCases
  module User
    class DeleteUser < Base
      def initialize(params, context: {})
        super(params, context: context)

        @user_repository = context.fetch(:user_repository) { ::Repositories::User.new }
      end

      def call
        can_perform_action?
        user = find_user
        delete_user user
        success(user)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ActiveRecord::RecordNotFound => e
        failure({ error: e, code: 404 })
      end

      private

      def find_user
        ::User.find @params[:id]
      end

      def delete_user(user)
        user.destroy!
      end

      def can_perform_action?
        user = @params[:user]
        user && policy(::User, user).can_delete?(@params[:id]) || raise(::Sav::Errors::PermissionDenied)
      end
    end
  end
end

