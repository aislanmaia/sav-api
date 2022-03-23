# frozen_string_literal: true

module UseCases
  module Client
    class CreateClient < Base
      def initialize(params, context: {})
        super(params, context: context)

        @client_repository = context.fetch(:client_repository) { ::Repositories::Client.new }
      end

      def call
        can_perform_action?
        client = create_client
        success(value: client)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ::StandardError => e
        failure({ error: e, code: 422 })
      end

      private

      def create_client
        ::Client.create!(
          name: client_params[:name],
          email: client_params[:email],
          phone: client_params[:phone],
          address: client_params[:address]
        )
      end

      def client_params
        @params.with_indifferent_access
      end

      def can_perform_action?
        user = @params[:user]
        user && policy(::Client, user).can_create? || raise(::Sav::Errors::PermissionDenied)
      end
    end
  end
end
