# frozen_string_literal: true

module UseCases
  module Client
    class DeleteClient < Base
      def initialize(params, context: {})
        super(params, context: context)

        @client_repository = context.fetch(:client_repository) { ::Repositories::Client.new }
      end

      def call
        can_perform_action?
        client = find_client
        delete_client client
        success(value: client)
      rescue ::Sav::Errors::PermissionDenied => e
        failure({ error: e, code: 403 })
      rescue ActiveRecord::RecordNotFound => e
        failure({ error: e, code: 404 })
      end

      private

      def find_client
        ::Client.find @params[:id]
      end

      def delete_client(client)
        client.destroy!
      end

      def can_perform_action?
        user = @params[:user]
        user && policy(::Client, user).can_delete? || raise(::Sav::Errors::PermissionDenied)
      end
    end
  end
end

