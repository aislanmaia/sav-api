# frozen_string_literal: true

module UseCases
  module User
    class UpdateUser < Base
      def initialize(params, context: {})
        super(params, context: context)

        @user_repository = context.fetch(:user_repository) { ::Repositories::User.new }
      end

      def call
        can_perform_action?
        user = find_user user_params[:id]
        update_user user
        success(user)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ::Sav::Errors::RecordNotFound => e
        failure({ error: e, code: 404 })
      end

      private

      def find_user(id)
        ::User.find id || raise(::Sav::Errors::RecordNotFound)
      end

      def update_user(user)
        user.update!(
          username: user_params[:name],
          email: user_params[:email],
          registry: user_params[:registry],
          password: user_params[:password]
        )
      end

      def user_params
        @params.to_h.slice(:id, :name, :email, :registry, :password).with_indifferent_access
      end

      def can_perform_action?
        user = @params[:user]
        user && policy(::User, user).can_update?(@params[:id]) || raise(::Sav::Errors::PermissionDenied)
      end
    end
  end
end

