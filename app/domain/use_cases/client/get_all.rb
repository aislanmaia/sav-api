# frozen_string_literal: true

module UseCases
  module Client
    class GetAll < Base
      def initialize(params, context: {})
        super(params, context)

        @client_repository = context.fetch(:client_repository) { ::Repositories::Client.new }
      end

      def call
        can_perform_action?
        clients = all_clients
        success(clients)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ActiveRecord::RecordNotFound => e
        failure({ error: e, code: 404 })
      end

      private

      def can_perform_action?
        user = @params[:user]
        user && policy(::Client, user).can_list? || raise(::Sav::Errors::PermissionDenied)
      end

      def all_clients
        @client_repository.all
      end
    end
  end
end