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
          name: client_params[:name],
          email: client_params[:email],
          phone: client_params[:phone],
          address: client_params[:address]
        )
      end

      def client_params
        @params.to_h.slice(:id, :name, :email, :phone, :address).with_indifferent_access
      end

      def can_perform_action?
        user = @params[:user]
        user && policy(::Client, user).can_update? || raise(::Sav::Errors::PermissionDenied)
      end
    end
  end
end

