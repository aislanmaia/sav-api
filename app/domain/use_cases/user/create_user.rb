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
        valid_role?
        convert_role
        user = create_user
        success(user)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ::Sav::Errors::RecordInvalid => e
        failure({ error: e, code: 422 })
      rescue ::StandardError => e
        failure({ error: e, code: 422 })
      end

      private

      def create_user
        user = ::User.create(
          username: user_params[:firstname].downcase,
          firstname: user_params[:firstname],
          lastname: user_params[:lastname],
          email: user_params[:email],
          registry: user_params[:registry],
          password: user_params[:password],
          role: user_params[:role]
        )
        user.valid? || raise(::Sav::Errors::RecordInvalid, user.errors.full_messages.first)
        user
      end

      def user_params
        @params.to_h.slice(:id, :name, :firstname, :lastname, :email, :registry, :password, :role).with_indifferent_access
      end

      def can_perform_action?
        user = @params[:user]
        user && policy(::User, user).can_create? || raise(::Sav::Errors::PermissionDenied)
      end

      def valid_role?
        return if @params[:role] != :admin

        raise(::Sav::Errors::RecordInvalid, 'user role is not valid!')
      end
    end
  end
end
