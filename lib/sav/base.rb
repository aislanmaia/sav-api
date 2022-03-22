# frozen_string_literal: true

module Sav
  class Base
    def initialize(params, context: {})
      @params = params
      @context = context
    end

    def call
      raise NotImplementedError
    end

    def success(value)
      Result.new true, value: value
    end

    def failure(errors)
      Result.new false, errors: errors
    end

    def policy(subject, user)
      klass = find_policy(subject)
      policy = klass.safe_constantize
      policy.new user
    end

    private

    def find_class_name(subject)
      case subject
      when Class
        subject
      when Symbol
        subject.to_s.camelize
      else
        subject.class
      end
    end

    def find_policy(subject)
      klass = find_class_name subject
      "#{klass}Policy"
    end
  end
end
