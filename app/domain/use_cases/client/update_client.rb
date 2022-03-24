# frozen_string_literal: true

module UseCases
  module Client
    class UpdateClient < Base
      def initialize(params, context: {})
        super(params, context: context)

        @client_repository = context.fetch(:client_repository) { ::Repositories::Client.new }
      end

      def call
        can_perform_action?
        client = find_client client_params[:id]
        update_client client
        success(client)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ::Sav::Errors::RecordNotFound => e
        failure({ error: e, code: 404 })
      end

      private

      def find_client(id)
        ::Client.find id || raise(::Sav::Errors::RecordNotFound)
      end

      def update_client(client)
        client.update!(
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

