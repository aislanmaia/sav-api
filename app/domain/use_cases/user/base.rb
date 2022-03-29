# frozen_string_literal: true

require 'sav/base'
require 'sav/errors'

module UseCases
  module User
    class Base < ::Sav::Base
      def initialize(params, context: {})
        super
        @params = params
      end

      def convert_role
        @params[:role] = ::User::ROLES.fetch(@params[:role].to_sym) { ::User::ROLES[:attendant] } if @params[:role]
      end
    end
  end
end
