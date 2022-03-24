# frozen_string_literal: true

module UseCases
  module User
    class CreateUser < Base
      def initialize(params, context: {})
        super(params, context: context)

        @user_repository = context.fetch(:user_repository) { ::Repositories::User.new }
      end

      def call
        can_perform_action?
        user = create_user
        success(user)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ::StandardError => e
        failure({ error: e, code: 422 })
      end

      private

      def create_user
        ::User.create!(
          username: user_params[:name],
          email: user_params[:email],
          registry: user_params[:registry],
          password: user_params[:password],
          role: user_params[:role]
        )
      end

      def user_params
        @params.to_h.slice(:id, :name, :email, :registry, :password, :role).with_indifferent_access
      end

      def can_perform_action?
        user = @params[:user]
        user && policy(::User, user).can_create? || raise(::Sav::Errors::PermissionDenied)
      end
    end
  end
end
