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
    end
  end
end
